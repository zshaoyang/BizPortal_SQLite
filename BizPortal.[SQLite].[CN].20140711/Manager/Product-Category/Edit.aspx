<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.EditCategoryPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131226"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("UpdateProductCategoryData") %></strong>
                    <span><a href="<%=ADMIN_URL("ProductCategoryManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("AddProductCategoryPage") %>" class="more_link"><%=LangRes.Text("AddProductCategoryData") %>+</a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminCategoryHandler") %>?action=101" method="post" enctype="multipart/form-data">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label for="txtCategoryName"><%=LangRes.Text("Name") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtCategoryName" name="Name" class="txt" maxlength="100" value="<%=TheCategory.Name %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtCategoryUrlName"><%=LangRes.Text("UrlName") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtCategoryUrlName" name="UrlName" class="txt" maxlength="30" value="<%=TheCategory.UrlName %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectCategoryParentId"><%=LangRes.Text("ParentCategory") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectCategoryParentId" name="ParentId" class="select">
                                        <option value="0"><%=LangRes.Text("SelectParentCategory") %></option>
                                    <% 
                                    foreach(Category category in RootCategoryList){
                                        if (category.CategoryId == TheCategory.CategoryId) { continue; }
                                    %>
                                        <option value="<%=category.CategoryId %>" <%=Helper.SELECTED("ParentId", category.CategoryId, TheCategory.ParentId) %>><%=category.Name %>(<%=category.UrlName %>)</option>
                                    <% } %>
                                    </select>
                                </td>

                                <th class="title" style="width:15%;"><label for="txtCategorySortOrder"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtCategorySortOrder" name="SortOrder" class="txt" maxlength="3" value="<%=TheCategory.SortOrder %>" /></td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="hidden" id="CategoryId" name="CategoryId" value="<%=TheCategory.CategoryId %>" />
                                    <input type="submit" value="<%=LangRes.Text("UpdateProductCategoryData") %>" class="submit" />
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    </form>
                </div>
            </div>
        </div>

<!-- #include file="../includes/_footer.html" -->

    </div>
</body>
</html>
