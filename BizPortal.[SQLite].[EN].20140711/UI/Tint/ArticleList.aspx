﻿<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.ArticleListPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/article.css?v=<%=AppInfo.Build %>" />
</head>
<body id="body">

<!-- #include file="includes/_head.html" -->

    <div id="main" class="wrap">
        <div id="position">
            <a href="<%=URL("HomePage") %>"><%=LangRes.Get("HomePage") %></a>
            <% if(TheCategory != null){ %>
            <em>&nbsp;</em>
            <a href="<%=URL("ArticleListPage") %>"><%=LangRes.Get("NewsOrActivityList") %></a>
            <% if(TheCategory.ParentCategory != null){ %>
            <em>&nbsp;</em>
            <a href="<%=URL("ArticleCategoryPage", TheCategory.ParentCategory.UrlName) %>"><%=TheCategory.ParentCategory.Name %></a>
            <% } %>
            <em>&nbsp;</em>
            <span><%=LangRes.Get("Category") %> - <%=TheCategory.Name %></span>
            <% } else { %>
            <em>&nbsp;</em>
            <span><%=LangRes.Get("NewsOrActivityList") %></span>
            <% } %>
        </div>

        <div id="content" class="<%=Helper.IF(BlockSetting.IsSetArticleListPageBlock || RootArticleCategoryList.Count > 0, "small") %>">
            <h2><% if(TheCategory != null){ %><%=LangRes.Get("ArticleCategory") %>&nbsp;-&nbsp;<%=TheCategory.Name %><% } else { %><%=LangRes.Get("AllNews") %><% } %></h2>
            <div class="panel">
                <div class="box">
                    <div class="box_inner">
                        <ul class="article_list">
                        <% for(int i = 0; i < ArticleList.Count; i++)
                            {
                                Article article = ArticleList[i];
                        %>
                            <li class="<%=Helper.IF(i % 2 != 0, "alt") %>">
                                <h4 class="title"><a target="_blank" href="<%=URL("ArticleDetailPage", article.ArticleId) %>" title="<%=article.Title %>" class="title_link"><%=article.Title %></a></h4>
                                <div class="info"><%=Helper.DATETIME(article.CreateTime) %></div>
                                <div class="brief"><%=Helper.CUT(article.Brief) %></div>
                            </li>
                        <% } %>
                        </ul>
                        <div class="clear"></div>

<% CurrentPager = ArticlePager; %>
<!-- #include file="includes/_pager.html" -->
                    </div>
                </div>
            </div>
        </div>

        <% if (BlockSetting.IsSetArticleListPageBlock || RootArticleCategoryList.Count > 0){ %>
        <div id="side">
        <% if (RootArticleCategoryList.Count > 0){ %>
            <div class="panel">
                <div class="bar">
                    <h4 class="title"><%=LangRes.Get("NewsCategory") %></h4>
                </div>

                <div class="box">
                    <div id="category_tree" class="box_inner">
                        <ul class="category_list">
                            <li><a href="<%=URL("ArticleListPage") %>" title="<%=LangRes.Get("AllNews") %>"><%=LangRes.Get("AllNews") %></a></li>
                        <% foreach(ArticleCategory category in RootArticleCategoryList)
                           {
                              List<ArticleCategory> childCategoryList = category.ChildCategoryList;
                        %>
                            <li>
                                <a href="<%=URL("ArticleCategoryPage", category.UrlName) %>" title="<%=category.Name %>" class="<%=Helper.IF(TheCategory != null && category.CategoryId == TheCategory.CategoryId, "current") %>"><%=category.Name %></a>
                            <% if (childCategoryList.Count > 0){ %>
                                <ul class="category_list">
                                <% foreach (ArticleCategory level2Category in childCategoryList) { %>
                                    <li><a href="<%=URL("ArticleCategoryPage", level2Category.UrlName) %>" title="<%=level2Category.Name %>" class="<%=Helper.IF(TheCategory != null && level2Category.CategoryId == TheCategory.CategoryId, "current") %>"><%=level2Category.Name %></a></li>
                                <% } %>
                                </ul>
                            <% } %>
                            </li>
                        <% } %>
                        </ul>
                    </div>
                </div>
            </div>
        <% } %>

        <% if(BlockSetting.IsSetArticleListPageBlock){ %>
            <div class="panel">
                <div class="bar">
                    <h4 class="title"><%=BlockSetting.ArticleListPageBlockTitle %></h4>
                </div>

                <div class="box">
                    <div class="box_inner custom_block">
                        <%=BlockSetting.ArticleListPageBlockContent %>
                    </div>
                </div>
            </div>
        <% } %>
        </div>
        <% } %>

        <div class="clear"></div>
    </div>


    <%=DisplaySetting.ArticleListPluginCode %>

<!-- #include file="includes/_foot.html" -->

</body>
</html>
