<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.SearchProductPage" %>

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
        <em>/</em>
        <a href="<%=URL("ProductListPage") %>"><%=LangRes.Get("ProductList") %></a>
        <em>/</em>
        <span><%=LangRes.Get("Search") %> - <%=Keywords %></span>
    </div>

    <div id="content">
        <div id="category_box">
            <div class="panel">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap"><h4><%=LangRes.Get("FilterCategory") %></h4></div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div class="panel_box_inner">
                        <ul class="category_list">
                            <li><a href="<%=URL("XSearchProductsPage", Keywords) %>" title="<%=LangRes.Get("UnlimitedCategory") %>"><%=LangRes.Get("UnlimitedCategory") %></a></li>
                        <% foreach(Category category in RootCategoryList)
                            {
                            List<Category> childCategoryList = category.ChildCategoryList;
                        %>
                            <li>
                                <a href="<%=URL("SearchCategoryProductsPage", category.CategoryId.ToString(), Keywords) %>" title="<%=category.Name %>" class="<%=Helper.IF(category.CategoryId == CategoryId && Level2CategoryId == 0, "current") %>"><%=category.Name %></a>
                            <% if (childCategoryList.Count > 0){ %>
                                <ul class="category_list">
                                <% foreach (Category level2Category in childCategoryList) { %>
                                    <li><a href="<%=URL("SearchCategory2ProductsPage", category.CategoryId.ToString(), level2Category.CategoryId.ToString(), Keywords) %>" title="<%=level2Category.Name %>" class="<%=Helper.IF(level2Category.CategoryId == Level2CategoryId, "current") %>"><%=level2Category.Name %></a></li>
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
            <h2><%=LangRes.Get("Search") %>&nbsp;-&nbsp;<%=Keywords %></h2>

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
