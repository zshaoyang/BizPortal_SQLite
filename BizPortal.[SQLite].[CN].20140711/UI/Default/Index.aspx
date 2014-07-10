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
                "SlideMode": <%=Helper.IF(SliderSetting.SlideMode, "true", "false") %>,
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

        var RecommendProductPlayer = null;
        function InitRecommendProductPlayer() {
            RecommendProductPlayer = new LanternSlide("recommend_product_panel", {
                "ItemSelector": "#recommend_product_panel .product_list",
                "Direction": 1, "Auto": false, "AutoSeconds": 3,
                "ShowButtons": false,
                "PlayCallback": function (activeIndex, index, isNext) {
                    $("#recommend_product_caption a.title").each(function () {
                        var sliderCaptionItem = $(this);
                        var sliderCaptionItemId = sliderCaptionItem.attr("id");
                        if (sliderCaptionItemId == "RecommendProductSliderCaption_" + index) {
                            if (!sliderCaptionItem.hasClass("active_title")) {
                                sliderCaptionItem.addClass("active_title");
                            }
                        }
                        else {
                            sliderCaptionItem.removeClass("active_title");
                        }
                    });
                }
            });
        }


        $(function () {
            InitSlider();
            InitRecommendProductPlayer();
        });
    </script>
</head>
<body id="body">

<!-- #include file="includes/_head.html" -->


    <% if(DisplaySetting.OpenHomeSlider){ %>
    <div id="slider">
        <div id="slide_player">
            <% foreach(LanternSlide slider in AllSliderList){ %>
            <div class="item">
                <a href="<%=slider.Link %>" title="<%=slider.Title %>" class="img_link"><img src="<%=SkinRoot %>images/loading.gif" _src="<%=slider.ImageWebPath %>" alt="<%=slider.Title %>" title="<%=slider.Title %>" /></a>
                <div class="caption"><a href="<%=slider.Link %>" title="<%=slider.Title %>"><%=slider.Name %></a></div>
            </div>
            <% } %>
        </div>
        <div id="slider_caption">
            <ul>
            <% for (int i = 0; i < AllSliderList.Count; i ++ )
               {
                   LanternSlide slider = AllSliderList[i]; 
            %>
                <li><a id="slider_caption_<%=i + 1 %>" href="<%=slider.Link%>" title="<%=slider.Title%>" class="<%=Helper.IF(i == 0, "active") %>" onclick="Slider.Play(<%=i+1 %>); return false;"><%=slider.Name%></a></li>
            <% } %>
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    <% } %>

    <div id="content">
        <% if (DisplaySetting.OpenProductModule && ((DisplaySetting.OpenArticleModule && DisplaySetting.ShowHomeNewArticle) || BlockSetting.IsSetHomePageBlock))
           { %>
        <div id="left">
        <% if(DisplaySetting.ShowHomeNewProduct && NewProductList != null && NewProductList.Count > 0){ %>
            <div id="new_product_panel" class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="<%=URL("ProductListPage") %>" class="title active_title"><%=LangRes.Get("NewProducts") %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div class="panel_box_inner">
                        <ul class="product_list">
                        <% foreach(Product product in NewProductList){ %>
                            <li>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                            </li>
                        <% } %>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>

            <div class="clear"></div>
        <% } %>

            <div class="panel">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap" id="recommend_product_caption">
                        <a id="RecommendProductSliderCaption_1" href="javascript:void(0);" class="title active_title" onclick="RecommendProductPlayer.Play(1); return false;"><%=LangRes.Get("RecommendProducts") %></a>
                    <% if (DisplaySetting.HomeProductCategoryIdList != null && DisplaySetting.HomeProductCategoryIdList.Count > 0){
                       for (int i = 0; i < DisplaySetting.HomeProductCategoryIdList.Count; i++ )
                       {
                           int categoryId = DisplaySetting.HomeProductCategoryIdList[i];
                           Category category = AllCategoryDic[categoryId];        
                    %>
                        <a id="RecommendProductSliderCaption_<%=i+2 %>" href="javascript:void(0);" class="title" onclick="RecommendProductPlayer.Play(<%=i+2 %>); return false;"><%=category.Name%></a>
                    <% }
                       } %>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div id="recommend_product_panel" class="panel_box_inner" style="height:<%=Math.Ceiling((float)DisplaySetting.HomeRecommendProductNumber / 4.0) * 200 %>px;">
                        <ul class="product_list" style="height:<%=Math.Ceiling((float)DisplaySetting.HomeRecommendProductNumber / (float)4) * 200 %>px;">
                        <% if (RecommendProductList.Count > 0) {
                            foreach (Product product in RecommendProductList)
                            { %>
                            <li>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                            </li>
                        <%  }
                           } else { %>
                            <li class="no_data"><%=LangRes.Get("NoRecommendProducts") %></li>
                        <% } %>
                        </ul>
                    <% foreach (KeyValuePair<int, List<Product>> categoryProductList in RecommendProductDic)
                       {
                           List<Product> productList = categoryProductList.Value;
                    %>
                        <ul class="product_list" style="height:<%=Math.Ceiling((float)DisplaySetting.HomeRecommendProductNumber / (float)4) * 200 %>px;">
                        <% if(productList.Count > 0){
                            foreach(Product product in productList){ %>
                            <li>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                            </li>
                        <%  }
                           } else { %>
                            <li class="no_data"><%=LangRes.Get("NoProductsOfRecommendCategory") %></li>
                        <% } %>
                        </ul>
                    <% } %>

                        <div class="clear"></div>
                    </div>
                </div>
            </div>

        </div>

        <div id="side">
        <% if (DisplaySetting.OpenArticleModule){ %>

            <% if (DisplaySetting.ShowHomeNewArticle && NewArticleList.Count > 0){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="<%=URL("ArticleListPage") %>" class="title active_title"><%=LangRes.Get("NewsOrActivity") %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box">
                    <div id="new_article_list" class="panel_box_inner">
                        <ul>
                        <% foreach(Article article in NewArticleList){ %>
                            <li><a href="<%=URL("ArticleDetailPage", article.ArticleId) %>" target="_blank" title="<%=article.Title %>"><%=Helper.CUT(article.Title, 18) %></a></li>
                        <% } %>
                        </ul>
                    </div>
                </div>
            </div>
            <% } %>

        <% } %>

        <% if (BlockSetting.IsSetHomePageBlock){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="javascript:void(0);" class="title active_title"><%=BlockSetting.HomePageBlockTitle %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box">
                    <div class="panel_box_inner custom_block">
                        <%=BlockSetting.HomePageBlockContent %>
                    </div>
                </div>
            </div>
        <% } %>
        </div>

        <% } else { %>

            <% if(DisplaySetting.OpenProductModule && DisplaySetting.ShowHomeNewProduct && NewProductList != null && NewProductList.Count > 0){ %>
            <div id="new_product_panel" class="panel large">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="<%=URL("ProductListPage") %>" class="title active_title"><%=LangRes.Get("NewProducts") %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div class="panel_box_inner">
                        <ul class="product_list" style="width:950px;">
                        <% foreach(Product product in NewProductList){ %>
                            <li>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                            </li>
                        <% } %>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>

            <div class="clear"></div>
            <% } %>

            <% if(DisplaySetting.OpenProductModule){ %>
            <div class="panel large">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap" id="recommend_product_caption">
                        <a id="RecommendProductSliderCaption_1" href="javascript:void(0);" class="title active_title" onclick="RecommendProductPlayer.Play(1); return false;"><%=LangRes.Get("RecommendProducts") %></a>
                    <% if (DisplaySetting.HomeProductCategoryIdList != null && DisplaySetting.HomeProductCategoryIdList.Count > 0){
                       for (int i = 0; i < DisplaySetting.HomeProductCategoryIdList.Count; i++ )
                       {
                           int categoryId = DisplaySetting.HomeProductCategoryIdList[i];
                           Category category = AllCategoryDic[categoryId];        
                    %>
                        <a id="RecommendProductSliderCaption_<%=i+2 %>" href="javascript:void(0);" class="title" onclick="RecommendProductPlayer.Play(<%=i+2 %>); return false;"><%=category.Name%></a>
                    <% }
                       } %>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div id="recommend_product_panel" class="panel_box_inner" style="width:950px;height:<%=Math.Ceiling((float)DisplaySetting.HomeRecommendProductNumber / (float)6) * 200 %>px;">
                        <ul class="product_list" style="width:950px;height:<%=Math.Ceiling((float)DisplaySetting.HomeRecommendProductNumber / (float)6) * 200 %>px;">
                        <% if (RecommendProductList.Count > 0){
                           foreach (Product product in RecommendProductList)
                           { %>
                            <li>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                            </li>
                        <% }
                            } else { %>
                            <li class="no_data"><%=LangRes.Get("NoRecommendProducts") %></li>
                        <% } %>
                        </ul>

                    <% foreach (KeyValuePair<int, List<Product>> categoryProductList in RecommendProductDic)
                       {
                         List<Product> productList = categoryProductList.Value;
                    %>
                        <ul class="product_list" style="width:950px;height:<%=Math.Ceiling((float)DisplaySetting.HomeRecommendProductNumber / (float)6) * 200 %>px;">
                        <% if(productList.Count > 0){
                            foreach(Product product in productList){ %>
                            <li>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_img"><img src="<%=Helper.IF(string.IsNullOrEmpty(product.Thumb), NoImagePath, product.ThumbWebPath) %>" alt="<%=product.Name %>" /></a>
                                <a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank" title="<%=product.Name %>" class="p_name"><%=product.Name %></a>
                            </li>
                        <%  }
                            } else { %>
                            <li class="no_data"><%=LangRes.Get("NoProductsOfRecommendCategory") %></li>
                        <% } %>
                        </ul>
                    <% } %>

                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <% } %>

            <% if(DisplaySetting.OpenArticleModule && DisplaySetting.ShowHomeNewArticle && NewArticleList.Count > 0){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="<%=URL("ArticleListPage") %>" class="title active_title"><%=LangRes.Get("NewsOrActivity") %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box large">
                    <div class="panel_box_inner" id="new_article_list">
                        <ul>
                        <% foreach(Article article in NewArticleList){ %>
                            <li><a href="<%=URL("ArticleDetailPage", article.ArticleId) %>" target="_blank" title="<%=article.Title %>"><%=Helper.CUT(article.Title, 18) %></a></li>
                        <% } %>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <% } %>
            
            <% if (BlockSetting.IsSetHomePageBlock){ %>
            <div class="clear"></div>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="javascript:void(0);" class="title active_title"><%=BlockSetting.HomePageBlockTitle %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box">
                    <div class="panel_box_inner custom_block">
                        <%=BlockSetting.HomePageBlockContent %>
                    </div>
                </div>
            </div>
            <% } %>
        <% } %>

        <div class="clear"></div>
    </div>

    <%=DisplaySetting.HomePluginCode %>

<!-- #include file="includes/_submain_nav.html" -->

<!-- #include file="includes/_foot.html" -->

</body>
</html>
