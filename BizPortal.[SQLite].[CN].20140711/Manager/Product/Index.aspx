<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.ProductPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=WebRoot %>Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131225"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageProductData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddProductPage") %>" class="more_link"><%=LangRes.Text("AddProductData") %>+</a></span>
                    <span><a href="<%=ADMIN_URL("ProductAttributeManagerPage") %>" class="more_link"><%=LangRes.Text("ManageProductAttribute") %></a></span>
                </div>
                <div class="main_content">
                    <div class="search_panel">
                        <form id="SearchForm" name="SearchForm" action="<%=ADMIN_URL("ProductManagerPage") %>" method="post">
                            <div id="basic_search_condition_container">
                                <table class="search_table" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <th style=""><label for="SearchKeywords"><%=LangRes.Text("SearchKeywords") %></label></th>
                                        <td style="width:25%;"><input type="text" id="SearchKeywords" name="Keywords" value="<%=SearchFilter.Keywords %>" class="txt" /></td>
                                        <th style=""><label for="SearchCategoryId"><%=LangRes.Text("Category") %></label></th>
                                        <td>
                                            <select id="SearchCategoryId" name="CategoryId" class="select" onchange="LoadChildCategoryList('<%=API_URL("AdminCategoryHandler") %>?action=200&CategoryId=' + $(this).val(),'SearchLevel2CategoryId', {'null': '<%=LangRes.Text("UnlimitedLevel2Category") %>'});">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                            <% foreach(Category category in RootCategoryList){ %>
                                                <option value="<%=category.CategoryId %>" <%=Helper.SELECTED("CategoryId", category.CategoryId, SearchFilter.CategoryId) %>><%=category.Name %>(<%=category.UrlName %>)</option>
                                            <% } %>
                                            </select>
                                            <select id="SearchLevel2CategoryId" name="Level2CategoryId" class="select">
                                                <option value="null"><%=LangRes.Text("UnlimitedLevel2Category") %></option>
                                            <% 
                                            if(SearchCategory != null){ 
                                                foreach(Category level2Category in SearchCategory.ChildCategoryList){
                                            %>
                                                <option value="<%=level2Category.CategoryId %>" <%=Helper.SELECTED("Level2CategoryId", level2Category.CategoryId, SearchFilter.Level2CategoryId) %>><%=level2Category.Name %>(<%=level2Category.UrlName %>)</option>
                                            <% 
                                                }
                                            } 
                                            %>
                                            </select>
                                        </td>
                                        <th style=""><label for="SearchRecommend"><%=LangRes.Text("RecommendToHomePage") %></label></th>
                                        <td style="width:25%;">
                                            <select id="SelectRecommend" name="Recommend" class="select">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                                <option value="True" <%=Helper.SELECTED("Recommend", true, SearchFilter.Recommend) %>><%=LangRes.Text("Yes") %></option>
                                                <option value="False" <%=Helper.SELECTED("Recommend", false, SearchFilter.Recommend) %>><%=LangRes.Text("No") %></option>
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
                                        <th style=""><label for="SearchStartPublicTime"><%=LangRes.Text("PublicTime") %></label></th>
                                        <td colspan="3">
                                            <input type="text" id="SearchStartPublicTime" name="StartPublicTime" value="<%=Helper.OUT_DATETIME(SearchFilter.StartPublicTime) %>" class="txt dt_txt" onclick="WdatePicker();" />
                                            ~
                                            <input type="text" id="SearchEndPublicTime" name="EndPublicTime" value="<%=Helper.OUT_DATETIME(SearchFilter.EndPublicTime) %>" class="txt dt_txt" onclick="WdatePicker();" />
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
                    <form id="ManageForm" action="<%=API_URL("AdminProductHandler") %>?action=105" method="post" enctype="application/x-www-form-urlencoded">
                    <table class="list_table product_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th style="width:50px;vertical-align:middle;"><input type="checkbox" id="CheckAll" onclick="CheckAllItems('CheckAll', 'ProductIds', 'CheckAll2');" />&nbsp;<label for="CheckAll">ID</label></th>
                                <th style="width:200px;"><%=LangRes.Text("Name") %></th>
                                <th style="width:200px;"><%=LangRes.Text("Category") %></th>
                                <th style="width:160px;"><%=LangRes.Text("Image") %></th>
                                <th><%=LangRes.Text("PublicTime") %></th>
                                <th><%=LangRes.Text("CommentCount") %></th>
                                <th><%=LangRes.Text("IsRecommend") %></th>
                                <th style="width:100px;">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach(Product product in ProductPageList)
                            {
                                SetProductCategory(product);
                        %>
                            <tr id="productItem_<%=product.ProductId %>">
                                <td><input type="checkbox" id="ProductIds_<%=product.ProductId %>" name="ProductIds" value="<%=product.ProductId %>" />&nbsp;<label for="ProductIds_<%=product.ProductId %>"><%=product.ProductId %></label></td>
                                <td><a href="<%=URL("ProductDetailPage", product.ProductId) %>" target="_blank"><%=Helper.HIGHLIGHT(product.Name, SearchFilter.Keywords) %></a></td>
                                <td>
                                    <div class="three_categories">
                                    <% if(product.Category != null){ %>
                                        <a href="<%=URL("CategoryPage", product.Category.UrlName) %>" target="_blank"><%=product.Category.Name %></a>
                                        <% if(product.Level2Category != null){ %>
                                        <a href="<%=URL("CategoryPage", product.Level2Category.UrlName) %>" target="_blank"><%=product.Level2Category.Name %></a>
                                        <% } %>
                                    <% } %>
                                        <div class="clear"></div>
                                    </div>
                                </td>
                                <td>
                                <% if (!string.IsNullOrEmpty(product.Logo) && !string.IsNullOrEmpty(product.Thumb)){ %>
                                    <a href="<%=product.LogoWebPath %>" target="_blank"><img src="<%=product.ThumbWebPath %>" alt="<%=product.Name %>" /></a>
                                <% } else { %>
                                    -
                                <% } %>
                                </td>
                                <td><%=Helper.DATETIME(product.PublicTime) %></td>
                                <td><%=product.TotalComment %></td>
                                <td><%=Helper.IF(product.Recommend, LangRes.Text("Yes"), LangRes.Text("No")) %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditProductPage", product.ProductId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteProduct_<%=product.ProductId %>" class="btn_delete_product" href="<%=API_URL("AdminProductHandler") %>?action=102&ProductId=<%=product.ProductId %>"><%=LangRes.Text("Delete") %></a>
                                </td>
                            </tr>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="8">
                                    <div class="tool_panel fl">
                                        <input type="checkbox" id="CheckAll2" onclick="CheckAllItems('CheckAll2', 'ProductIds', 'CheckAll');" />&nbsp;<input id="SubmitDeleteChecked" type="submit" value="<%=LangRes.Text("DeleteSelected") %>" class="btn" onclick="return DeleteProducts('ManageForm', '<%=LangRes.Text("ConfirmToDeleteSelectedProductData") %>');" />
                                    </div>
                                    <div class="fl">
<% CurrentPager = ProductPager; %>
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
        $(function () {
            $("td .btn_delete_product").each(function () {
                var btn = $(this);
                var btnId = btn.attr("id");

                btn.bind("click", function () {

                    QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheProduct") %>", function (jsonData) {
                        var actionResult = parseInt(jsonData["Result"]);
                        var productId = jsonData["Data"];
                        var productItem = $("#productItem_" + productId);

                        productItem.fadeOut(400);
                        setTimeout(function () {
                            productItem.remove();
                        }, 500);

                        return true;
                    });
                    return false;
                });
            });
        });
    </script>
</body>
</html>
