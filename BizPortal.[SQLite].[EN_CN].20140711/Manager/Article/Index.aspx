<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.ArticlePage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=WebRoot %>Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/article-min.js?v=20131225"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageArticleData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddArticlePage") %>" class="more_link"><%=LangRes.Text("AddArticleData") %>+</a></span>
                </div>
                <div class="main_content">
                    <div class="search_panel">
                        <form id="SearchForm" name="SearchForm" action="<%=ADMIN_URL("ArticleManagerPage") %>" method="post">
                            <div id="basic_search_condition_container">
                                <table class="search_table" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <th style=""><label for="SearchKeywords"><%=LangRes.Text("SearchKeywords") %></label></th>
                                        <td style="width:25%;"><input type="text" id="SearchKeywords" name="Keywords" value="<%=SearchFilter.Keywords %>" class="txt" /></td>
                                        <th style=""><label for="SearchCategoryId"><%=LangRes.Text("Category") %></label></th>
                                        <td colspan="3">
                                            <select id="SearchCategoryId" name="CategoryId" class="select" onchange="LoadChildCategoryList('<%=API_URL("AdminCategoryHandler") %>?action=600&CategoryId=' + $(this).val(),'SearchLevel2CategoryId', {'null': '<%=LangRes.Text("UnlimitedLevel2Category") %>'});">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                            <% foreach(ArticleCategory category in RootArticleCategoryList){ %>
                                                <option value="<%=category.CategoryId %>" <%=Helper.SELECTED("CategoryId", category.CategoryId, SearchFilter.CategoryId) %>><%=category.Name %>(<%=category.UrlName %>)</option>
                                            <% } %>
                                            </select>
                                            <select id="SearchLevel2CategoryId" name="Level2CategoryId" class="select">
                                                <option value="null"><%=LangRes.Text("UnlimitedLevel2Category") %></option>
                                            <% 
                                            if(SearchCategory != null){ 
                                                foreach(ArticleCategory level2Category in SearchCategory.ChildCategoryList){
                                            %>
                                                <option value="<%=level2Category.CategoryId %>" <%=Helper.SELECTED("Level2CategoryId", level2Category.CategoryId, SearchFilter.Level2CategoryId) %>><%=level2Category.Name %>(<%=level2Category.UrlName %>)</option>
                                            <% 
                                                }
                                            } 
                                            %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style=""><label for="SearchEnableComment"><%=LangRes.Text("EnableComment") %></label></th>
                                        <td style="width:25%;">
                                            <select id="SearchEnableComment" name="EnableComment" class="select">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                                <option value="True" <%=Helper.SELECTED("EnableComment", true, SearchFilter.EnableComment) %>><%=LangRes.Text("Yes") %></option>
                                                <option value="False" <%=Helper.SELECTED("EnableComment", false, SearchFilter.EnableComment) %>><%=LangRes.Text("No") %></option>
                                            </select>
                                        </td>
                                        <th style=""><label for="SearchStartCreateTime"><%=LangRes.Text("CreateTime") %></label></th>
                                        <td colspan="3">
                                            <input type="text" id="SearchStartCreateTime" name="StartCreateTime" value="<%=Helper.OUT_DATETIME(SearchFilter.StartCreateTime) %>" class="txt dt_txt" onclick="WdatePicker();" />
                                            ~
                                            <input type="text" id="SearchEndCreateTime" name="EndCreateTime" value="<%=Helper.OUT_DATETIME(SearchFilter.EndCreateTime) %>" class="txt dt_txt" onclick="WdatePicker();" />
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div class="search_submit">
                                <input type="submit" id="SubmitSearch" name="SubmitSearch" value="<%=LangRes.Text("Search") %>" class="submit" />
                            </div>
                        </form>
                    </div>

                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                    <form id="ManageForm" action="<%=API_URL("AdminArticleHandler") %>?action=103" method="post" enctype="application/x-www-form-urlencoded">
                    <table class="list_table article_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th style="width:50px;vertical-align:middle;"><input type="checkbox" id="CheckAll" onclick="CheckAllItems('CheckAll', 'ArticleIds', 'CheckAll2');" />&nbsp;<label for="CheckAll">ID</label></th>
                                <th><%=LangRes.Text("Title") %></th>
                                <th style="width:200px;"><%=LangRes.Text("Category") %></th>
                                <th><%=LangRes.Text("CreateTime") %></th>
                                <th><%=LangRes.Text("CommentCount") %></th>
                                <th style="width:100px;">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach(Article article in ArticlePageList)
                            {
                                SetArticleCategory(article);
                        %>
                            <tr id="articleItem_<%=article.ArticleId %>">
                                <td><input type="checkbox" id="ArticleIds_<%=article.ArticleId %>" name="ArticleIds" value="<%=article.ArticleId %>" />&nbsp;<label for="ArticleIds_<%=article.ArticleId %>"><%=article.ArticleId %></label></td>
                                <td><a href="<%=URL("ArticleDetailPage", article.ArticleId) %>" target="_blank"><%=Helper.HIGHLIGHT(article.Title, SearchFilter.Keywords) %></a></td>
                                <td>
                                    <div class="three_categories">
                                    <% if (article.Category != null) { %>
                                        <a href="<%=URL("ArticleCategoryPage", article.Category.UrlName) %>" target="_blank"><%=article.Category.Name %></a>
                                        <% if (article.Level2Category != null) { %>
                                        <a href="<%=URL("ArticleCategoryPage", article.Level2Category.UrlName) %>" target="_blank"><%=article.Level2Category.Name %></a>
                                        <% } %>
                                    <% } %>
                                        <div class="clear"></div>
                                    </div>
                                </td>
                                <td><%=Helper.DATETIME(article.CreateTime) %></td>
                                <td><%=article.TotalComment %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditArticlePage", article.ArticleId) %>">[<%=LangRes.Text("Edit") %>]</a>
                                    &nbsp;
                                    <a id="btnDeleteArticle_<%=article.ArticleId %>" class="btn_delete_article" href="<%=API_URL("AdminArticleHandler") %>?action=102&ArticleId=<%=article.ArticleId %>">[<%=LangRes.Text("Delete") %>]</a>
                                </td>
                            </tr>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="6">
                                    <div class="tool_panel fl">
                                        <input type="checkbox" id="CheckAll2" onclick="CheckAllItems('CheckAll2', 'ArticleIds', 'CheckAll');" />&nbsp;<input id="SubmitDeleteChecked" type="submit" value="<%=LangRes.Text("DeleteSelected") %>" class="btn" onclick="return DeleteArticles('ManageForm', '<%=LangRes.Text("ConfirmToDeleteSelectedNewsData") %>');" />
                                    </div>
                                    <div class="fl">
<% CurrentPager = ArticlePager; %>
<!-- #include file="../includes/_pager.html" -->
                                    </div>
                                    <div class="clear"></div>
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

    <script type="text/javascript">
        $("td .btn_delete_article").each(function () {
            var btn = $(this);
            var btnId = btn.attr("id");

            btn.bind("click", function () {

                QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheNews") %>", function (jsonData) {
                    var actionResult = parseInt(jsonData["Result"]);
                    var articleId = jsonData["Data"];
                    var articleItem = $("#articleItem_" + articleId);

                    articleItem.fadeOut(400);
                    setTimeout(function () {
                        articleItem.remove();
                    }, 500);

                    return true;
                });
                return false;
            });
        });
    </script>
</body>
</html>
