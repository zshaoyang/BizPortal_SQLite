<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.BlockSettingPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>

<!-- #include file="../includes/_editor.html" -->
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("BlockingSetting") %></strong>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=500" method="post" enctype="application/x-www-form-urlencoded" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:27%;"><label for="txtHomePageBlockTitle"><%=LangRes.Text("HomePageBlockTitle") %>:</label></th>
                                <td class="field" style=""><input type="text" id="txtHomePageBlockTitle" name="HomePageBlockTitle" class="txt" maxlength="250" value="<%=BlockSetting.HomePageBlockTitle %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtHomePageBlockContent"><%=LangRes.Text("HomePageBlockContent") %>:</label></th>
                                <td class="field" style="">
                                    <textarea id="txtHomePageBlockContent" name="HomePageBlockContent" cols="55" rows="10" class="txt"><%=DEnCodeHelper.HtmlEncode(BlockSetting.HomePageBlockContent) %></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtProductListPageBlockTitle"><%=LangRes.Text("ProductListPageBlockTitle") %>:</label></th>
                                <td class="field" style=""><input type="text" id="txtProductListPageBlockTitle" name="ProductListPageBlockTitle" class="txt" maxlength="250" value="<%=BlockSetting.ProductListPageBlockTitle %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtProductListPageBlockContent"><%=LangRes.Text("ProductListPageBlockContent") %>:</label></th>
                                <td class="field" style="">
                                    <textarea id="txtProductListPageBlockContent" name="ProductListPageBlockContent" cols="55" rows="10" class="txt"><%=DEnCodeHelper.HtmlEncode(BlockSetting.ProductListPageBlockContent) %></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtProductDetailPageBlockTitle"><%=LangRes.Text("ProductDetailPageBlockTitle") %>:</label></th>
                                <td class="field" style=""><input type="text" id="txtProductDetailPageBlockTitle" name="ProductDetailPageBlockTitle" class="txt" maxlength="250" value="<%=BlockSetting.ProductDetailPageBlockTitle %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtProductDetailPageBlockContent"><%=LangRes.Text("ProductDetailPageBlockContent") %>:</label></th>
                                <td class="field" style="">
                                    <textarea id="txtProductDetailPageBlockContent" name="ProductDetailPageBlockContent" cols="55" rows="10" class="txt"><%=DEnCodeHelper.HtmlEncode(BlockSetting.ProductDetailPageBlockContent) %></textarea>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtArticleListPageBlockTitle"><%=LangRes.Text("ArticleListPageBlockTitle") %>:</label></th>
                                <td class="field" style=""><input type="text" id="txtArticleListPageBlockTitle" name="ArticleListPageBlockTitle" class="txt" maxlength="250" value="<%=BlockSetting.ArticleListPageBlockTitle %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleListPageBlockContent"><%=LangRes.Text("ArticleListPageBlockContent") %>:</label></th>
                                <td class="field" style="">
                                    <textarea id="txtArticleListPageBlockContent" name="ArticleListPageBlockContent" cols="55" rows="10" class="txt"><%=DEnCodeHelper.HtmlEncode(BlockSetting.ArticleListPageBlockContent) %></textarea>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtArticleDetailPageBlockTitle"><%=LangRes.Text("ArticleDetailPageBlockTitle") %>:</label></th>
                                <td class="field" style=""><input type="text" id="txtArticleDetailPageBlockTitle" name="ArticleDetailPageBlockTitle" class="txt" maxlength="250" value="<%=BlockSetting.ArticleDetailPageBlockTitle %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtArticleDetailPageBlockContent"><%=LangRes.Text("ArticleDetailPageBlockContent") %>:</label></th>
                                <td class="field" style="">
                                    <textarea id="txtArticleDetailPageBlockContent" name="ArticleDetailPageBlockContent" cols="55" rows="10" class="txt"><%=DEnCodeHelper.HtmlEncode(BlockSetting.ArticleDetailPageBlockContent) %></textarea>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtTopicDetailPageBlockTitle"><%=LangRes.Text("TopicDetailPageBlockTitle") %>:</label></th>
                                <td class="field" style=""><input type="text" id="txtTopicDetailPageBlockTitle" name="TopicDetailPageBlockTitle" class="txt" maxlength="250" value="<%=BlockSetting.TopicDetailPageBlockTitle %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtTopicDetailPageBlockContent"><%=LangRes.Text("TopicDetailPageBlockContent") %>:</label></th>
                                <td class="field" style="">
                                    <textarea id="txtTopicDetailPageBlockContent" name="TopicDetailPageBlockContent" cols="55" rows="10" class="txt"><%=DEnCodeHelper.HtmlEncode(BlockSetting.TopicDetailPageBlockContent) %></textarea>
                                </td>
                            </tr>

                        </tbody>

                        <tfoot>
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
    <script type="text/javascript">
        $(function(){

            InitEditor('txtHomePageBlockContent');
            InitEditor('txtProductListPageBlockContent');
            InitEditor('txtProductDetailPageBlockContent');
            InitEditor('txtArticleListPageBlockContent');
            InitEditor('txtArticleDetailPageBlockContent');
            InitEditor('txtTopicDetailPageBlockContent');

            <%if(ActionResult.Data != null){%>
            var TempCategoryJson = <%=ActionResult.Data %>;
        
            for(var prpName in TempCategoryJson){
                var prpValue = TempCategoryJson[prpName];
                if(prpValue != null && prpValue != ""){
                    $("input[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                    $("textarea[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                }
            }
            <%}%>

        });
    </script>
</body>
</html>
