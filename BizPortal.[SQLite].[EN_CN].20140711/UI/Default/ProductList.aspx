<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.ProductListPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->

    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/product.css?v=<%=AppInfo.Build %>" />
</head>
<body id="body">
    
<!-- #include file="includes/_head.html" -->

    <div id="position">
        <a href="<%=URL("HomePage") %>"><%=LangRes.Get("HomePage") %></a>
        <% if(TheCategory != null){ %>
        <em>/</em>
        <a href="<%=URL("ProductListPage") %>"><%=LangRes.Get("ProductList") %></a>
        <% if(TheCategory.ParentCategory != null){ %>
        <em>/</em>
        <a href="<%=URL("CategoryPage", TheCategory.ParentCategory.UrlName) %>"><%=TheCategory.ParentCategory.Name %></a>
        <% } %>
        <em>/</em>
        <span><%=LangRes.Get("Category") %> - <%=TheCategory.Name %></span>
        <% } else { %>
        <em>/</em>
        <span><%=LangRes.Get("ProductList") %></span>
        <% } %>
    </div>

    <div id="content">
        <div id="category_box">
            <div class="panel">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap"><h4><%=LangRes.Get("ProductCategory") %></h4></div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div class="panel_box_inner">
                        <ul class="category_list">
                            <li><a href="<%=URL("ProductListPage") %>" title="<%=LangRes.Get("AllProducts") %>"><%=LangRes.Get("AllProducts") %></a></li>
                        <% foreach(Category category in RootCategoryList)
                           {
                            List<Category> childCategoryList = category.ChildCategoryList;
                        %>
                            <li>
                                <a href="<%=URL("CategoryPage", category.UrlName) %>" title="<%=category.Name %>" class="<%=Helper.IF(TheCategory != null && category.CategoryId == TheCategory.CategoryId, "current") %>"><%=category.Name %></a>
                            <% if (childCategoryList.Count > 0){ %>
                                <ul class="category_list">
                                <% foreach (Category level2Category in childCategoryList) { %>
                                    <li><a href="<%=URL("CategoryPage", level2Category.UrlName) %>" title="<%=level2Category.Name %>" class="<%=Helper.IF(TheCategory != null && level2Category.CategoryId == TheCategory.CategoryId, "current") %>"><%=level2Category.Name %></a></li>
                                <% } %>
                                </ul>
                            <% } %>
                            </li>
                        <% } %>
                        </ul>
                    </div>
                </div>
            </div>

            <% if(BlockSetting.IsSetProductListPageBlock){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="javascript:void(0);" class="title active_title"><%=BlockSetting.ProductListPageBlockTitle %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box">
                    <div class="panel_box_inner custom_block">
                        <%=BlockSetting.ProductListPageBlockContent %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div id="product_box">
            <h2><% if(TheCategory != null){ %><%=LangRes.Get("ProductCategory") %>&nbsp;-&nbsp;<%=TheCategory.Name %><% } else { %><%=LangRes.Get("AllProducts") %><% } %></h2>

            <div id="product_list_panel">
                <ul class="product_list">
                <% foreach(Product product in ProductList){ %>
                    <li>
                        <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                        <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                    </li>
                <% } %>
                </ul>
                <div class="clear">
                </div>

<% CurrentPager = ProductPager; %>
<!-- #include file="includes/_pager.html" -->
            </div>
        </div>

        <div class="clear"></div>
    </div>

<!-- #include file="includes/_foot.html" -->

</body>
</html>
