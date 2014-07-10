<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.PageSEOSettingPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("PageSEOSetting") %></strong>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=600" method="post" enctype="application/x-www-form-urlencoded" onsubmit="$('#SubmitButton').attr('disabled',true);">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="PageActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="title" style="width:30%;"><label for="txtHomePageSEOTitle"><%=LangRes.Text("HomePageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtHomePageSEOTitle" name="HomePageSEOTitle" class="txt" value="<%=PageSEOSetting.HomePageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("HomePageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtHomePageSEOKeywords"><%=LangRes.Text("HomePageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtHomePageSEOKeywords" name="HomePageSEOKeywords" class="txt" value="<%=PageSEOSetting.HomePageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("HomePageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtHomePageSEODescription"><%=LangRes.Text("HomePageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtHomePageSEODescription" name="HomePageSEODescription" class="txt" value="<%=PageSEOSetting.HomePageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("HomePageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtArticleDetailPageSEOTitle"><%=LangRes.Text("ArticleDetailPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleDetailPageSEOTitle" name="ArticleDetailPageSEOTitle" class="txt" value="<%=PageSEOSetting.ArticleDetailPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleDetailPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleDetailPageSEOKeywords"><%=LangRes.Text("ArticleDetailPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleDetailPageSEOKeywords" name="ArticleDetailPageSEOKeywords" class="txt" value="<%=PageSEOSetting.ArticleDetailPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleDetailPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleDetailPageSEODescription"><%=LangRes.Text("ArticleDetailPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleDetailPageSEODescription" name="ArticleDetailPageSEODescription" class="txt" value="<%=PageSEOSetting.ArticleDetailPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleDetailPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtArticleListPageSEOTitle"><%=LangRes.Text("ArticleListPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleListPageSEOTitle" name="ArticleListPageSEOTitle" class="txt" value="<%=PageSEOSetting.ArticleListPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleListPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleListPageSEOKeywords"><%=LangRes.Text("ArticleListPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleListPageSEOKeywords" name="ArticleListPageSEOKeywords" class="txt" value="<%=PageSEOSetting.ArticleListPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleListPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleListPageSEODescription"><%=LangRes.Text("ArticleListPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleListPageSEODescription" name="ArticleListPageSEODescription" class="txt" value="<%=PageSEOSetting.ArticleListPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleListPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtSearchArticlesPageSEOTitle"><%=LangRes.Text("SearchArticlesPageSEOTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtSearchArticlesPageSEOTitle" name="SearchArticlesPageSEOTitle" class="txt" value="<%=PageSEOSetting.SearchArticlesPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("SearchArticlesPageSEOTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtSearchArticlesPageSEOKeywords"><%=LangRes.Text("SearchArticlesPageSEOKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtSearchArticlesPageSEOKeywords" name="SearchArticlesPageSEOKeywords" class="txt" value="<%=PageSEOSetting.SearchArticlesPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("SearchArticlesPageSEOKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtSearchArticlesPageSEODescription"><%=LangRes.Text("SearchArticlesPageSEODescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtSearchArticlesPageSEODescription" name="SearchArticlesPageSEODescription" class="txt" value="<%=PageSEOSetting.SearchArticlesPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("SearchArticlesPageSEODescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtArticleCategoryPageSEOTitle"><%=LangRes.Text("ArticleCategoryPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleCategoryPageSEOTitle" name="ArticleCategoryPageSEOTitle" class="txt" value="<%=PageSEOSetting.ArticleCategoryPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleCategoryPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleCategoryPageSEOKeywords"><%=LangRes.Text("ArticleCategoryPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleCategoryPageSEOKeywords" name="ArticleCategoryPageSEOKeywords" class="txt" value="<%=PageSEOSetting.ArticleCategoryPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleCategoryPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleCategoryPageSEODescription"><%=LangRes.Text("ArticleCategoryPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtArticleCategoryPageSEODescription" name="ArticleCategoryPageSEODescription" class="txt" value="<%=PageSEOSetting.ArticleCategoryPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("ArticleCategoryPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtProductDetailPageSEOTitle"><%=LangRes.Text("ProductDetailPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtProductDetailPageSEOTitle" name="ProductDetailPageSEOTitle" class="txt" value="<%=PageSEOSetting.ProductDetailPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("ProductDetailPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtProductDetailPageSEOKeywords"><%=LangRes.Text("ProductDetailPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtProductDetailPageSEOKeywords" name="ProductDetailPageSEOKeywords" class="txt" value="<%=PageSEOSetting.ProductDetailPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("ProductDetailPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtProductDetailPageSEODescription"><%=LangRes.Text("ProductDetailPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtProductDetailPageSEODescription" name="ProductDetailPageSEODescription" class="txt" value="<%=PageSEOSetting.ProductDetailPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("ProductDetailPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtProductListPageSEOTitle"><%=LangRes.Text("ProductListPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtProductListPageSEOTitle" name="ProductListPageSEOTitle" class="txt" value="<%=PageSEOSetting.ProductListPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("ProductListPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtProductListPageSEOKeywords"><%=LangRes.Text("ProductListPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtProductListPageSEOKeywords" name="ProductListPageSEOKeywords" class="txt" value="<%=PageSEOSetting.ProductListPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("ProductListPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtProductListPageSEODescription"><%=LangRes.Text("ProductListPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtProductListPageSEODescription" name="ProductListPageSEODescription" class="txt" value="<%=PageSEOSetting.ProductListPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("ProductListPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtSearchProductsPageSEOTitle"><%=LangRes.Text("SearchProductsPageSEOTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtSearchProductsPageSEOTitle" name="SearchProductsPageSEOTitle" class="txt" value="<%=PageSEOSetting.SearchProductsPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("SearchProductsPageSEOTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtSearchProductsPageSEOKeywords"><%=LangRes.Text("SearchProductsPageSEOKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtSearchProductsPageSEOKeywords" name="SearchProductsPageSEOKeywords" class="txt" value="<%=PageSEOSetting.SearchProductsPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("SearchProductsPageSEOKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtSearchProductsPageSEODescription"><%=LangRes.Text("SearchProductsPageSEODescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtSearchProductsPageSEODescription" name="SearchProductsPageSEODescription" class="txt" value="<%=PageSEOSetting.SearchProductsPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("SearchProductsPageSEODescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtCategoryPageSEOTitle"><%=LangRes.Text("ProductCategoryPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtCategoryPageSEOTitle" name="CategoryPageSEOTitle" class="txt" value="<%=PageSEOSetting.CategoryPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("ProductCategoryPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtCategoryPageSEOKeywords"><%=LangRes.Text("ProductCategoryPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtCategoryPageSEOKeywords" name="CategoryPageSEOKeywords" class="txt" value="<%=PageSEOSetting.CategoryPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("ProductCategoryPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtCategoryPageSEODescription"><%=LangRes.Text("ProductCategoryPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtCategoryPageSEODescription" name="CategoryPageSEODescription" class="txt" value="<%=PageSEOSetting.CategoryPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("ProductCategoryPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtTopicDetailPageSEOTitle"><%=LangRes.Text("TopicDetailPageTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtTopicDetailPageSEOTitle" name="TopicDetailPageSEOTitle" class="txt" value="<%=PageSEOSetting.TopicDetailPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("TopicDetailPageTitleFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtTopicDetailPageSEOKeywords"><%=LangRes.Text("TopicDetailPageMetaKeywordsFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtTopicDetailPageSEOKeywords" name="TopicDetailPageSEOKeywords" class="txt" value="<%=PageSEOSetting.TopicDetailPageSEOKeywords %>" />
                                    <span class="desc"><%=LangRes.Text("TopicDetailPageMetaKeywordsFormatNote") %></span>
                                </td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtTopicDetailPageSEODescription"><%=LangRes.Text("TopicDetailPageMetaDescriptionFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtTopicDetailPageSEODescription" name="TopicDetailPageSEODescription" class="txt" value="<%=PageSEOSetting.TopicDetailPageSEODescription %>" />
                                    <span class="desc"><%=LangRes.Text("TopicDetailPageMetaDescriptionFormatNote") %></span>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtMessageBoardPageSEOTitle"><%=LangRes.Text("MessageBoardPageSEOTitleFormat") %>:</label></th>
                                <td class="field" colspan="3">
                                    <input type="text" id="txtMessageBoardPageSEOTitle" name="MessageBoardPageSEOTitle" class="txt" value="<%=PageSEOSetting.MessageBoardPageSEOTitle %>" />
                                    <span class="desc"><%=LangRes.Text("MessageBoardPageSEOTitleFormatNote") %></span>
                                </td>
                            </tr>
                            
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("SaveSetting") %>" class="submit" />
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
