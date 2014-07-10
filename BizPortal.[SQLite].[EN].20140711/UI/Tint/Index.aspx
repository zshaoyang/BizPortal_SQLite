<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.HomePage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->
    <script type="text/javascript" src="<%=WebRoot %>Scripts/sleeping-tiger-lib/lantern-slide-min.js?v=<%=AppInfo.Build %>"></script>

    <script type="text/javascript">
        var Slider = null;

        function InitSlider() {
            Slider = new LanternSlide("slide_player", {
                "ItemSelector": "#slide_player .item",
                <% if(SliderSetting.ShowCaption){ %>
                "CaptionSelector": "#slide_player .item .caption",
                <% } %>
                "Direction": <%=SliderSetting.SlideDirection %>, "AutoSeconds": <%=SliderSetting.PlaySpeed / 1000 %>, "Auto": <%=Helper.IF(SliderSetting.AutoPlay, "true", "false") %>,
                "AnimateSpeed": 1000, "SlideMode": <%=Helper.IF(SliderSetting.SlideMode, "true", "false") %>,
                "ShowButtons": <%=Helper.IF(SliderSetting.ShowNumberButtons, "true", "false") %>, "ShowPrevNextButtons": <%=Helper.IF(SliderSetting.ShowArrowButtons, "true", "false") %>, 
                "PlayCallback": function (activeIndex, index, isNext) {
                    $("#slider_caption li a").each(function () {
                        var sliderCaptionItem = $(this);
                        var sliderCaptionItemId = sliderCaptionItem.attr("id");
                        if (sliderCaptionItemId == "slider_caption_" + index) {
                            if (!sliderCaptionItem.hasClass("active")) {
                                sliderCaptionItem.addClass("active");
                            }
                        }
                        else {
                            sliderCaptionItem.removeClass("active");
                        }
                    });
                }
            });

        }




        $(function () {
            InitSlider();

            InitMenus('#recommend_product_panel .performance_title .title', '#recommend_product_panel .performance_panel .product_list', 'active');

            FixImageSize('.performance_panel .product_list .product_img_link img', 125, 125);
        });
    </script>
</head>
<body id="body">

<!-- #include file="includes/_head.html" -->

    <% if(DisplaySetting.OpenHomeSlider){ %>
    <div id="slider" class="wrap">
        <div id="slide_player">
            <% foreach(LanternSlide slider in AllSliderList){ %>
            <div class="item">
                <a href="<%=slider.Link %>" title="<%=slider.Title %>" class="img_link"><img src="<%=SkinRoot %>images/loading.gif" _src="<%=slider.ImageWebPath %>" alt="<%=slider.Title %>" title="<%=slider.Title %>" /></a>
                <div class="caption"><a href="<%=slider.Link %>" title="<%=slider.Title %>"><%=slider.Name %></a></div>
            </div>
            <% } %>
        </div>
        <div class="clear"></div>
    </div>
    <% } %>

    <div id="main" class="wrap">
    <% if(DisplaySetting.OpenProductModule){ %>
        
        <div id="recommend_product_panel" class="wrap performance">
            <div class="performance_title">
                <a href="<%=URL("ProductListPage") %>" onclick="return false;" class="title active" data="AllRecommendProductList"><%=LangRes.Get("RecommendProducts") %></a>
                <% if (DisplaySetting.HomeProductCategoryIdList != null && DisplaySetting.HomeProductCategoryIdList.Count > 0){
                   for (int i = 0; i < DisplaySetting.HomeProductCategoryIdList.Count; i++ )
                   {
                        int categoryId = DisplaySetting.HomeProductCategoryIdList[i];
                        Category category = AllCategoryDic[categoryId];        
                %>
                    <a href="javascript:void(0);" class="title" onclick="return false;" data="RecommendProductList_<%=categoryId %>"><%=category.Name%></a>
                <% }
                   } %>
            </div>
            <div class="performance_panel">
                <ul id="AllRecommendProductList" class="product_list">
                <% if (RecommendProductList.Count > 0){
                    foreach(Product product in RecommendProductList){ %>
                    <li class="product_item">
                        <div class="product_item_inner">
                            <a class="product_img_link" href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                            <h3 class="product_name"><a href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><%=product.Name %></a></h3>
                        </div>
                    </li>
                <%  }
                   } else { %>
                    <li class="product_item no_data"><%=LangRes.Get("NoRecommendProducts") %></li>
                <% } %>
                </ul>

                <% foreach (KeyValuePair<int, List<Product>> categoryProductList in RecommendProductDic)
                   {
                    List<Product> productList = categoryProductList.Value;
                %>
                <ul id="RecommendProductList_<%=categoryProductList.Key %>" class="product_list none">
                <% if (productList.Count > 0) {
                    foreach (Product product in productList)
                    { 
                %>
                    <li class="product_item">
                        <div class="product_item_inner">
                            <a class="product_img_link" href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                            <h3 class="product_name"><a href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><%=product.Name %></a></h3>
                        </div>
                    </li>
                <%  }
                   } else { %>
                    <li class="product_item no_data"><%=LangRes.Get("NoProductsOfRecommendCategory") %></li>
                <% } %>
                </ul>
                <% } %>

                <div class="clear"></div>
            </div>
        </div>
        
        <% if(DisplaySetting.ShowHomeNewProduct){ %>
        <div class="wrap divide"></div>

        <div id="new_product_panel" class="wrap performance">
            <div class="performance_title">
                <a href="<%=URL("ProductListPage") %>" class="title active"><%=LangRes.Get("NewProducts") %></a>
            </div>
            <div class="performance_panel">
                <ul class="product_list">
                <% foreach(Product product in NewProductList){ %>
                    <li class="product_item">
                        <div class="product_item_inner">
                            <a class="product_img_link" href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                            <h3 class="product_name"><a href="<%=URL("ProductDetailPage", product.ProductId) %>" title="<%=product.Name %>" target="_blank"><%=product.Name %></a></h3>
                        </div>
                    </li>
                <% } %>
                </ul>

                <div class="clear"></div>
            </div>
        </div>
        <% } %>

    <% } %>

    <% if(DisplaySetting.OpenArticleModule && DisplaySetting.ShowHomeNewArticle && NewArticleList.Count > 0){ %>
        <% if (DisplaySetting.OpenProductModule) { %>
        <div class="wrap divide"></div>
        <% } %>

        <div id="new_article_panel" class="wrap performance">
            <div class="performance_title">
                <a href="<%=URL("ArticleListPage") %>" class="title active"><%=LangRes.Get("NewsOrActivity") %></a>
            </div>
            <div class="performance_panel">
                <ul class="article_list">
                <% foreach(Article article in NewArticleList){ %>
                    <li class="article_item">
                        <a class="article_link" href="<%=URL("ArticleDetailPage", article.ArticleId) %>" title="<%=article.Title %>" target="_blank"><%=article.Title %></a>
                    </li>
                <% } %>
                </ul>

                <div class="clear"></div>
            </div>
        </div>
    <% } %>

    <% if(BlockSetting.IsSetHomePageBlock){ %>
        <div class="wrap divide"></div>

        <div class="wrap performance">
            <div class="performance_title">
                <a href="javascript:void(0);" onclick="return false;" class="title active"><%=BlockSetting.HomePageBlockTitle %></a>
            </div>
            <div class="performance_panel custom_block">
                <%=BlockSetting.HomePageBlockContent %>
            </div>
        </div>
    <% } %>
    </div>


    <%=DisplaySetting.HomePluginCode %>

<!-- #include file="includes/_submain_nav.html" -->

<!-- #include file="includes/_foot.html" -->

</body>
</html>
