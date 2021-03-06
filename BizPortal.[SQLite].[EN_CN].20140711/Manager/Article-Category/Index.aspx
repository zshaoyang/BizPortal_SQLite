﻿<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.ArticleCategoryPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131225"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageArticleCategoryData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddArticleCategoryPage") %>" class="more_link"><%=LangRes.Text("AddArticleCategoryData") %>+</a></span>
                </div>
                <div class="main_content">
                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                    <table class="list_table category_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th><%=LangRes.Text("Name") %></th>
                                <th><%=LangRes.Text("URLAddress") %></th>
                                <th><%=LangRes.Text("ParentCategory") %></th>
                                <th><%=LangRes.Text("ArticleCount") %></th>
                                <th><%=LangRes.Text("SortOrder") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach (ArticleCategory rootCategory in RootArticleCategoryList)
                            {
                        %>
                            <tr class="root" id="categoryItem_<%=rootCategory.CategoryId %>">
                                <td><%=rootCategory.CategoryId %></td>
                                <td class="name"><a href="<%=ADMIN_URL("EditArticleCategoryPage", rootCategory.CategoryId) %>"><%=rootCategory.Name %></a></td>
                                <td><a href="<%=URL("ArticleCategoryPage", rootCategory.UrlName) %>" target="_blank"><%=HostURL %><%=URL("ArticleCategoryPage", rootCategory.UrlName) %></a></td>
                                <td>-</td>
                                <td><%=rootCategory.ArticleCount %></td>
                                <td><%=rootCategory.SortOrder %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditArticleCategoryPage", rootCategory.CategoryId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteCategory_<%=rootCategory.CategoryId %>" class="btn_delete_category" href="<%=API_URL("AdminCategoryHandler") %>?action=502&CategoryId=<%=rootCategory.CategoryId %>"><%=LangRes.Text("Delete") %></a>
                                </td>
                            </tr>
                            <%
                              if(rootCategory.ChildCategoryList != null && rootCategory.ChildCategoryList.Count > 0){
                                foreach (ArticleCategory level2Category in rootCategory.ChildCategoryList) 
                                {
                            %>
                                <tr class="level2" id="categoryItem_<%=level2Category.CategoryId %>">
                                    <td><%=level2Category.CategoryId %></td>
                                    <td class="name"><a href="<%=ADMIN_URL("EditArticleCategoryPage", level2Category.CategoryId) %>"><%=level2Category.Name %></a></td>
                                    <td><a href="<%=URL("ArticleCategoryPage", level2Category.UrlName) %>" target="_blank"><%=HostURL %><%=URL("ArticleCategoryPage", level2Category.UrlName) %></a></td>
                                    <td><a href="<%=URL("ArticleCategoryPage", level2Category.ParentCategory.UrlName) %>" target="_blank"><%=level2Category.ParentCategory.Name %></a></td>
                                    <td><%=level2Category.ArticleCount %></td>
                                    <td><%=level2Category.SortOrder %></td>
                                    <td>
                                        <a href="<%=ADMIN_URL("EditArticleCategoryPage", level2Category.CategoryId) %>"><%=LangRes.Text("Edit") %></a>
                                        &nbsp;
                                        <a id="btnDeleteCategory_<%=level2Category.CategoryId %>" class="btn_delete_category" href="<%=API_URL("AdminCategoryHandler") %>?action=502&CategoryId=<%=level2Category.CategoryId %>"><%=LangRes.Text("Delete") %></a>
                                    </td>
                                </tr>
                            <%
                                } 
                              }
                            %>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="7">&nbsp;</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

<!-- #include file="../includes/_footer.html" -->

    </div>

    <script type="text/javascript">
        $(".category_list td .btn_delete_category").each(function () {
            var btn = $(this);
            var btnId = btn.attr("id");

            btn.bind("click", function () {
                QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheArticleCategory") %>", function (jsonData) {
                    var actionResult = parseInt(jsonData["Result"]);
                    var categoryId = jsonData["Data"];
                    var categoryItem = $("#categoryItem_" + categoryId);

                    categoryItem.fadeOut(400);
                    setTimeout(function () {
                        categoryItem.remove();
                    }, 500);

                    return true;
                });

                return false;
            });
        });
    </script>
</body>
</html>
