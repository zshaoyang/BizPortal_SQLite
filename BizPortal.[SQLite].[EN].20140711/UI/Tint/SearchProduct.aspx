<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.SearchProductPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/product.css?v=<%=AppInfo.Build %>" />
</head>
<body id="body">

<!-- #include file="includes/_head.html" -->

    <div id="main" class="wrap">
        <div id="position">
            <a href="<%=URL("HomePage") %>"><%=LangRes.Get("HomePage") %></a>
            <em>&nbsp;</em>
            <a href="<%=URL("ProductListPage") %>"><%=LangRes.Get("ProductList") %></a>
            <em>&nbsp;</em>
            <span><%=LangRes.Get("Search") %> - <%=Keywords %></span>
        </div>

        <div id="side">
            <div class="panel">
                <div class="bar">
                    <h4 class="title"><%=LangRes.Get("FilterCategory") %></h4>
                </div>

                <div class="box">
                    <div id="category_tree" class="box_inner">
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
                    <h4 class="title"><%=BlockSetting.ProductListPageBlockTitle %></h4>
                </div>

                <div class="box">
                    <div class="box_inner custom_block">
                        <%=BlockSetting.ProductListPageBlockContent %>
                    </div>
                </div>
            </div>
            <% } %>

        </div>

        <div id="content">
            <h2><%=LangRes.Get("Search") %>&nbsp;-&nbsp;<%=Keywords %></h2>

            <div class="panel">
                <div class="box">
                    <div class="box_inner">
                    <% if (ProductList.Count > 0){ %>
                        <ul class="product_list">
                        <% foreach(Product product in ProductList){ %>
                            <li class="product_item">
                                <div class="product_item_inner">
                                    <a class="product_img_link" href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                    <h3 class="product_name"><a href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><%=product.Name %></a></h3>
                                </div>
                            </li>
                        <% } %>
                        </ul>
                        <div class="clear">
                        </div>

                        <div class="line"></div>
                    <% } %>

<% CurrentPager = ProductPager; %>
<!-- #include file="includes/_pager.html" -->
                    </div>
                </div>
            </div>
        </div>

        <div class="clear"></div>
    </div>

    <script type="text/javascript">
        $(function () {
            FixImageSize('.panel .product_list .product_img_link img', 115, 115);
        });
    </script>

    <%=DisplaySetting.ProductListPluginCode %>

<!-- #include file="includes/_foot.html" -->

</body>
</html>
