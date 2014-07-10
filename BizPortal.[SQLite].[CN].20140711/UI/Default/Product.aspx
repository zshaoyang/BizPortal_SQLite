<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.ProductDetailPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/product.css?v=<%=AppInfo.Build %>" />
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/comment.css?v=<%=AppInfo.Build %>" />
    <script type="text/javascript" src="<%=WebRoot %>Scripts/content/product-min.js?v=<%=AppInfo.Build %>"></script>      
</head>
<body id="body">
    
<!-- #include file="includes/_head.html" -->

    <div id="position">
        <a href="<%=URL("HomePage") %>"><%=LangRes.Get("HomePage") %></a>
        <em>/</em>
        <a href="<%=URL("ProductListPage") %>"><%=LangRes.Get("AllProducts") %></a>
        <% if(TheProduct.Category != null){ %>
        <em>/</em>
        <a href="<%=URL("CategoryPage", TheProduct.Category.UrlName) %>"><%=TheProduct.Category.Name %></a>
        <% } %>
        <% if(TheProduct.Level2Category != null){ %>
        <em>/</em>
        <a href="<%=URL("CategoryPage", TheProduct.Level2Category.UrlName) %>"><%=TheProduct.Level2Category.Name %></a>
        <% } %>
        <em>/</em>
        <span><%=TheProduct.Name %></span>
    </div>

    <div id="content">
        <div id="product_box" class="wrap">
            <h2><%=TheProduct.Name %></h2>

            <div id="product_list_panel">
                <div id="product_overview">
                    <div id="product_logo">
                        <a href="<%=Helper.IF(string.IsNullOrEmpty(TheProduct.Logo), NoImagePath, TheProduct.LogoWebPath) %>" target="_blank"><img src="<%=Helper.IF(string.IsNullOrEmpty(TheProduct.Logo), NoImagePath, TheProduct.LogoWebPath) %>" alt="<%=TheProduct.Name %>" /></a>
                    </div>
                    <div id="product_info">
                        <ul>
                            <li class="info"><label class="name"><%=LangRes.Get("ProductName") %>:</label><span class="value"><%=TheProduct.Name %></span></li>
                            <li class="info">
                                <label class="name"><%=LangRes.Get("ProductCategory") %>:</label>
                                <span class="value">
                                <% if(TheProduct.Category != null){ %>
                                    <a href="<%=URL("CategoryPage", TheProduct.Category.UrlName) %>"><%=TheProduct.Category.Name %></a>
                                <% } %>
                                <% if(TheProduct.Level2Category != null){ %>
                                    <em>/</em>
                                    <a href="<%=URL("CategoryPage", TheProduct.Level2Category.UrlName) %>"><%=TheProduct.Level2Category.Name %></a>
                                <% } %>
                                </span>
                            </li>
                            <li class="info"><label class="name"><%=LangRes.Get("PublicTime") %>:</label><span class="value"><%=Helper.DATE(TheProduct.PublicTime) %></span></li>
                        <% foreach (ProductAttribute productAttribute in TheProduct.AttributeList)
                           {
                               AttributeGroup attributeGroup = AllAttributeGroupDic[productAttribute.AttributeGroupId];
                               if (attributeGroup.Type == AttributeGroupTypes.Text) { continue; }
                        %>
                            <li class="info">
                                <label class="name" title="<%=attributeGroup.Title %>"><%=attributeGroup.Name %>：</label>
                                <span class="value">
                                <% if(attributeGroup.Type == AttributeGroupTypes.Boolean){ %>
                                    <%=Helper.IF(StringHelper.TryParse<bool>(productAttribute.Value, false), LangRes.Get("Yes"), LangRes.Get("No")) %>
                                <% } else{ %>
                                    <%=productAttribute.Value %>
                                <% } %>
                                </span>
                            </li>
                        <% } %>
                        </ul>
                    </div>

                    <div class="clear"></div>
                </div>

                <div class="grid" id="product_attribute">
                    <div class="grid_bar">
                        <a href="javascript:void(0);" class="carte active attribute_menu" onclick="return false;" title="<%=LangRes.Get("ProductIntro") %>" data="ProductDetailPanel"><span class="cl"></span><span class="cc"><%=LangRes.Get("ProductIntro") %></span><span class="cr"></span></a>
                        <% foreach (ProductAttribute productAttribute in TheProduct.AttributeList)
                           {
                            AttributeGroup attributeGroup = AllAttributeGroupDic[productAttribute.AttributeGroupId];
                            if (attributeGroup.Type != AttributeGroupTypes.Text) { continue; }
                        %>
                            <a href="javascript:void(0);" class="carte attribute_menu" onclick="return false;" title="<%=attributeGroup.Title %>" data="ProductAttribute_<%=productAttribute.ProductAttributeId %>"><span class="cl"></span><span class="cc"><%=attributeGroup.Name%></span><span class="cr"></span></a>
                        <% } %>
                    </div>

                    <div class="grid_box attribute_item" id="ProductDetailPanel">
                        <div id="text_content"><%=TheProduct.Detail %></div>
                    </div>

                    <% foreach (ProductAttribute productAttribute in TheProduct.AttributeList)
                       {
                        AttributeGroup attributeGroup = AllAttributeGroupDic[productAttribute.AttributeGroupId];
                        if (attributeGroup.Type != AttributeGroupTypes.Text) { continue; }
                    %>
                    <div class="grid_box attribute_item none" id="ProductAttribute_<%=productAttribute.ProductAttributeId %>">
                        <div class="attribute_content"><%=productAttribute.Value %></div>
                    </div>
                    <% } %>
                </div>

                <div class="clear"></div>
            </div>

            <% if(BlockSetting.IsSetProductDetailPageBlock){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="javascript:void(0);" class="title active_title"><%=BlockSetting.ProductDetailPageBlockTitle %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box">
                    <div class="panel_box_inner custom_block">
                        <%=BlockSetting.ProductDetailPageBlockContent %>
                    </div>
                </div>
            </div>
            <% } %>


            <% if (DisplaySetting.OpenProductComment == FunctionOpenTypes.ForceOpen || TheProduct.EnableComment || SiteSetting.OpenEmailContact){ %>
            <div id="post_comment_panel" class="panel">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                    <% if (DisplaySetting.OpenProductComment == FunctionOpenTypes.ForceOpen || TheProduct.EnableComment) { %>
                        <a href="javascript:void(0);" class="title comment_menu" data="comment_list_box"><%=LangRes.Get("CommentList") %></a>
                        <a href="javascript:void(0);" class="title comment_menu" data="post_comment_box"><%=LangRes.Get("PostComment") %></a>
                    <% } %>
                    <% if (SiteSetting.OpenEmailContact) { %>
                        <a href="javascript:void(0);" class="title comment_menu" data="post_email_box"><%=LangRes.Get("EmailContact") %></a>
                    <% } %>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                
                <% if (DisplaySetting.OpenProductComment == FunctionOpenTypes.ForceOpen || TheProduct.EnableComment) { %>
                <div class="panel_box comment_panel_item" id="comment_list_box">
                    <div class="panel_box_inner">
                        <ul class="comment_list">
                        <% for (int i = 0; i < CommentPageList.Count; i++ )
                           {
                               Comment comment = CommentPageList[i];
                               int layer = CommentPager.RecordCount - (CommentPager.PageIndex - 1) * CommentPager.PageSize - i;
                        %>
                            <li class="comment_item<%=Helper.IF(i % 2 == 0, " alt") %>">
                                <div class="comment_title">
                                    <h5>
                                        <a class="layer" href="#Comment_<%=layer %>">#<%=string.Format(LangRes.Get("Floor"), layer) %></a>
                                        <a id="Comment_<%=layer %>" name="Comment_<%=layer %>"></a>
                                        <%=comment.AuthorName%>
                                    </h5>
                                    <span class="info"><%=Helper.DATETIME(comment.CreateTime)%></span>
                                </div>
                                <div class="comment_body"><%=comment.Content%></div>
                                <% if(comment.ReplyTime.Date != DateTime.MinValue.Date){ %>
                                <div class="comment_reply">
                                    <div class="comment_title">
                                        <h5><%=LangRes.Get("AdminReply") %>:</h5>
                                        <span class="info"><%=Helper.DATETIME(comment.ReplyTime)%></span>
                                    </div>
                                    <div class="comment_body"><%=comment.ReplyContent%></div>
                                </div>
                                <% } %>
                            </li>
                        <% } %>
                        </ul>

<% CurrentPager = CommentPager; %>
<!-- #include file="includes/_pager.html" -->
                    </div>
                </div>

                <div class="panel_box comment_panel_item post_comment_panel" id="post_comment_box">
                    <div class="panel_box_inner">
                    <form id="PostCommentForm" action="<%=API_URL("OperationHandler") %>?action=100" method="post" enctype="application/x-www-form-urlencoded">
                        <div class="author_name">
                            <label for="txtAuthorName"><%=LangRes.Get("YourName") %>:</label>
                            <input type="text" id="txtAuthorName" name="AuthorName" class="txt" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="author_email">
                            <label for="txtAuthorEmail"><%=LangRes.Get("EmailAddress") %>:</label>
                            <input type="text" id="txtAuthorEmail" name="AuthorEmail" class="txt" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="comment_content">
                            <textarea id="txtContent" name="Content" class="txt" cols="55" rows="6"></textarea>
                            <span style="color:red;">*</span>
                        </div>
                        <div id="ActionMessageBox" class="comment_content action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                        <div class="post_submit">
                            <input type="hidden" id="BelongType" name="BelongType" value="<%=CommentBelongTypes.Product %>" />
                            <input type="hidden" id="TargetId" name="TargetId" value="<%=TheProduct.ProductId %>" />
                            <input type="submit" id="SubmitComment" name="SubmitComment" class="submit" value="<%=LangRes.Get("SubmitComment") %>" onclick="SubmitPostCommentForm('PostCommentForm', 'SubmitComment'); return false;" />
                        </div>
                    </form>
                    </div>
                </div>
                <% } %>

                <% if(SiteSetting.OpenEmailContact){ %>
                <div class="panel_box comment_panel_item post_comment_panel" id="post_email_box">
                    <div class="panel_box_inner">
                    <form id="PostEmailForm" action="<%=API_URL("OperationHandler") %>?action=200" method="post" enctype="application/x-www-form-urlencoded">
                        <div class="post_title">
                            <label for="txtEmailTitle"><%=LangRes.Get("EmailTitle") %>:</label>
                            <input type="text" id="txtEmailTitle" name="EmailTitle" class="txt" value="<%=string.Format(LangRes.Get("AboutProduct"), TheProduct.Name) %>" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="author_name">
                            <label for="txtEmailSender"><%=LangRes.Get("YourName") %>:</label>
                            <input type="text" id="txtEmailSender" name="EmailSender" class="txt" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="comment_content">
                            <textarea id="txtEmailContent" name="EmailContent" class="txt" cols="55" rows="6"></textarea>
                            <span style="color:red;">*</span>
                        </div>
                        <div id="ActionMessageBox2" class="comment_content action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                        <div class="post_submit">
                            <input type="hidden" id="EmailTargetId" name="TargetId" value="<%=TheProduct.ProductId %>" />
                            <input type="hidden" id="EmailBelongType" name="BelongType" value="<%=CommentBelongTypes.Product %>" />
                            <input type="submit" id="SubmitEmail" name="SubmitEmail" class="submit" value="<%=LangRes.Get("SendEmail") %>" onclick="SubmitPostEmailForm('PostEmailForm', 'SubmitEmail'); return false;" />
                        </div>
                    </form>
                    </div>
                </div>
                <% } %>

            </div>
            <% } %>

        </div>

        <div class="clear"></div>
    </div>

    <script type="text/javascript">
        $(function () {
            InitAttributeMenus();
            FixImageSize("#product_logo a img", 600);

            <% if (DisplaySetting.OpenProductComment == FunctionOpenTypes.ForceOpen || TheProduct.EnableComment || SiteSetting.OpenEmailContact) { %>
            InitMenus("#post_comment_panel .bar .comment_menu", "#post_comment_panel .comment_panel_item", "active_title");
            <% if(ActionResult.Result != PageActionResultType.Default){ %>
            alert('<%=ActionResult.Message %>');
            <% } %>
            <% } %>
        });
    </script>

<!-- #include file="includes/_foot.html" -->

</body>
</html>

