<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.DisplaySettingPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>

<!-- #include file="../includes/_editor.html" -->

    <script type="text/javascript">
        var AllSkins = {};
        <% foreach(KeyValuePair<string, Skin> skinItem in AllSkins){ %>
        AllSkins["<%=skinItem.Key %>"] = { "DirectoryName": "<%=skinItem.Value.DirectoryName %>", "LogoSize": "<%=skinItem.Value.LogoSize %>" };
        <% } %>

        function SelectSkin() {
            var selectSkin = $("#selectSkinDirectory").val();
            $("#OptimumLogoSize").html(AllSkins[selectSkin]["LogoSize"]);
        }
    </script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("DisplaySetting") %></strong>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=200" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="PageActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;border-bottom:1px dotted #CCCCCC;">
                                    <input type="submit" id="Submit1" value="<%=LangRes.Text("SaveSetting") %>" class="submit" />
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label for="selectSkinDirectory"><%=LangRes.Text("Skin") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectSkinDirectory" name="SkinDirectory" class="select" onchange="SelectSkin();">
                                    <% foreach(KeyValuePair<string, Skin> skinItem in AllSkins){ %>
                                        <option value="<%=skinItem.Key %>" <%=Helper.SELECTED("SkinDirectory", skinItem.Key, DisplaySetting.SkinDirectory) %>><%=skinItem.Value.SkinName %></option>
                                    <% } %>
                                    </select>
                                </td>
                                <th class="title" style="width:15%;"><label for="txtCommentInterval"><%=LangRes.Text("CommentInterval") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtCommentInterval" name="CommentInterval" class="txt" value="<%=DisplaySetting.CommentInterval %>" /></td>
                            </tr>

                            <tr>
                                <th class="title"><label for="LogoFile">Logo:</label></th>
                                <td class="field">
                                    <% if(!string.IsNullOrEmpty(DisplaySetting.LogoPath)){ %>
                                    <div class="product_img">
                                        <a href="<%=DisplaySetting.LogoWebPath %>?rand=<%=Globals.Now %>" target="_blank"><img src="<%=DisplaySetting.LogoWebPath %>?rand=<%=Globals.Now %>" alt="<%=DisplaySetting.LogoWebPath %>" /></a>
                                    </div>
                                    <%} %>
                                    
                                    <div><input type="file" id="LogoFile" name="LogoFile" class="txt" /></div>
                                    <div class="desc"><%=LangRes.Text("UploadLogoFileNotes") %></div>
                                    <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<span id="OptimumLogoSize"><%=CurrentSkin.LogoSize %></span></div>
                                </td>
                                <th class="title"><label for="FavIconFile">Favorite Icon:</label></th>
                                <td class="field">
                                    <% if(!string.IsNullOrEmpty(DisplaySetting.FavIconPath)){ %>
                                    <div class="product_img">
                                        <a href="<%=DisplaySetting.FavIconWebPath %>?rand=<%=Globals.Now %>" target="_blank"><img src="<%=DisplaySetting.FavIconWebPath %>?rand=<%=Globals.Now %>" alt="<%=DisplaySetting.FavIconWebPath %>" /></a>
                                    </div>
                                    <%} %>

                                    <div><input type="file" id="FavIconFile" name="FavIconFile" class="txt" /></div>
                                    <div class="desc"><%=LangRes.Text("UploadFavIconNotes") %></div>
                                    <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):16x16, 32x32</div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectOpenHomeSlider"><%=LangRes.Text("HomeLanternSlide") %>:</label></th>
                                <td class="field">
                                    <select id="selectOpenHomeSlider" name="OpenHomeSlider" class="select" onchange="YesOrNoShowOrHide('selectOpenHomeSlider', 'linkSliderManagerPage');">
                                        <option value="True" <%=Helper.SELECTED("OpenHomeSlider", true, DisplaySetting.OpenHomeSlider) %>><%=LangRes.Text("Show") %></option>
                                        <option value="False" <%=Helper.SELECTED("OpenHomeSlider", false, DisplaySetting.OpenHomeSlider) %>><%=LangRes.Text("DoNotShow") %></option>
                                    </select>
                                    &nbsp;
                                    <a id="linkSliderManagerPage" href="<%=ADMIN_URL("SliderManagerPage") %>"><%=LangRes.Text("SetLanternSlide") %></a>
                                </td>

                                <th class="title"><label for="selectCustomizeMainNavigation"><%=LangRes.Text("MainNavigation") %>:</label></th>
                                <td class="field">
                                    <select id="selectCustomizeMainNavigation" name="CustomizeMainNavigation" class="select" onchange="YesOrNoShowOrHide('selectCustomizeMainNavigation', 'linkNavManagerPage');">
                                        <option value="False" <%=Helper.SELECTED("CustomizeMainNavigation", false, DisplaySetting.CustomizeMainNavigation) %>><%=LangRes.Text("DefaultSetting") %></option>
                                        <option value="True" <%=Helper.SELECTED("CustomizeMainNavigation", true, DisplaySetting.CustomizeMainNavigation) %>><%=LangRes.Text("CustomizeSetting") %></option>
                                    </select>
                                    &nbsp;
                                    <a id="linkNavManagerPage" href="<%=ADMIN_URL("NavManagerPage") %>"><%=LangRes.Text("SetNavigation") %></a>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectShowGoogleTranslatorTool"><%=LangRes.Text("GoogleTranslatorTool") %>:</label></th>
                                <td class="field" colspan="3">
                                    <select id="selectShowGoogleTranslatorTool" name="ShowGoogleTranslatorTool" class="select" onchange="YesOrNoShowOrHide('selectShowGoogleTranslatorTool', 'GoogleTranslatorToolConfigPanel');">
                                        <option value="True" <%=Helper.SELECTED("ShowGoogleTranslatorTool", true, DisplaySetting.ShowGoogleTranslatorTool) %>><%=LangRes.Text("Show") %></option>
                                        <option value="False" <%=Helper.SELECTED("ShowGoogleTranslatorTool", false, DisplaySetting.ShowGoogleTranslatorTool) %>><%=LangRes.Text("DoNotShow") %></option>
                                    </select>
                                    &nbsp;
                                    <div id="GoogleTranslatorToolConfigPanel">
                                    <% foreach(KeyValuePair<string, string> langItem in Vars.LangNameDic){ %>
                                        <span class="item">
                                            <label for="GoogleTranslatorToolLanguages_<%=langItem.Key %>"><input type="checkbox" id="GoogleTranslatorToolLanguages_<%=langItem.Key %>" name="GoogleTranslatorToolLanguages" value="<%=langItem.Key %>" <%=Helper.IF(DisplaySetting.GoogleTranslatorToolLanguages == null || DisplaySetting.GoogleTranslatorToolLanguages.Contains(langItem.Key), " checked='checked'") %> />&nbsp;<img src="<%=WebRoot %>Images/lang/<%=langItem.Key %>.jpg" alt="<%=langItem.Value %>" /><%=langItem.Value %></label>
                                        </span>
                                    <% } %>
                                    </div>

                                    <div class="clear"></div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectOpenTopicModule"><%=LangRes.Text("OpenTopicModule") %>:</label></th>
                                <td class="field" colspan="3">
                                    <div>
                                        <select id="selectOpenTopicModule" name="OpenTopicModule" class="select" onchange="YesOrNoShowOrHide('selectOpenTopicModule', 'TopicModuleSettingPanel');">
                                            <option value="True" <%=Helper.SELECTED("OpenTopicModule", true, DisplaySetting.OpenTopicModule) %>><%=LangRes.Text("OpenTheModule") %></option>
                                            <option value="False" <%=Helper.SELECTED("OpenTopicModule", false, DisplaySetting.OpenTopicModule) %>><%=LangRes.Text("CloseTheModule") %></option>
                                        </select>
                                    </div>

                                    <div id="TopicModuleSettingPanel" class="child_setting_panel">
                                        <table class="editor_table" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th class="title"><label for="selectOpenTopicComment" class="item_t"><%=LangRes.Text("TopicCommentSwitch") %>：</label></th>
                                                <td class="field">
                                                    <select id="selectOpenTopicComment" name="OpenTopicComment" class="select">
                                                        <option value="<%=FunctionOpenTypes.Custom %>" <%=Helper.SELECTED("OpenTopicComment", FunctionOpenTypes.Custom, DisplaySetting.OpenTopicComment) %>><%=LangRes.Text("OpenTopicCommentCustomType") %></option>
                                                        <option value="<%=FunctionOpenTypes.ForceOpen %>" <%=Helper.SELECTED("OpenTopicComment", FunctionOpenTypes.ForceOpen, DisplaySetting.OpenTopicComment) %>><%=LangRes.Text("OpenTopicCommentForceOpenType") %></option>
                                                        <option value="<%=FunctionOpenTypes.ForceClose %>" <%=Helper.SELECTED("OpenTopicComment", FunctionOpenTypes.ForceClose, DisplaySetting.OpenTopicComment) %>><%=LangRes.Text("OpenTopicCommentForceCloseType") %></option>
                                                    </select>
                                                </td>

                                                <th class="title"><label for="selectNeedValidateTopicComment" class="item_t"><%=LangRes.Text("NeedValidateComment") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectNeedValidateTopicComment" name="NeedValidateTopicComment" class="select">
                                                        <option value="True" <%=Helper.SELECTED("NeedValidateTopicComment", true, DisplaySetting.NeedValidateTopicComment) %>><%=LangRes.Text("NeedValidate") %></option>
                                                        <option value="False" <%=Helper.SELECTED("NeedValidateTopicComment", false, DisplaySetting.NeedValidateTopicComment) %>><%=LangRes.Text("NotNeedValidate") %></option>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtTopicCommentListPageSize" class="item_t"><%=LangRes.Text("CommentListPageSize") %>:</label></th>
                                                <td class="field"><input type="text" id="txtTopicCommentListPageSize" name="TopicCommentListPageSize" maxlength="3" class="txt" value="<%=DisplaySetting.TopicCommentListPageSize %>" /></td>
                                                <th class="title">&nbsp;</th>
                                                <td class="field">&nbsp;</td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtTopicDetailPluginCode" class="item_t"><%=LangRes.Text("DetailPagePluginCode") %>:</label></th>
                                                <td class="field" colspan="3"><textarea id="txtTopicDetailPluginCode" name="TopicDetailPluginCode" class="txt" cols="40" rows="5"><%=DisplaySetting.TopicDetailPluginCode %></textarea></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="selectOpenProductModule"><%=LangRes.Text("OpenProductModule") %>:</label></th>
                                <td class="field" colspan="3">
                                    <div>
                                        <select id="selectOpenProductModule" name="OpenProductModule" class="select" onchange="YesOrNoShowOrHide('selectOpenProductModule', 'ProductSettingModule');">
                                            <option value="True" <%=Helper.SELECTED("OpenProductModule", true, DisplaySetting.OpenProductModule) %>><%=LangRes.Text("OpenTheModule") %></option>
                                            <option value="False" <%=Helper.SELECTED("OpenProductModule", false, DisplaySetting.OpenProductModule) %>><%=LangRes.Text("CloseTheModule") %></option>
                                        </select>
                                    </div>

                                    <div id="ProductSettingModule" class="child_setting_panel">
                                        <table class="editor_table" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th class="title"><label for="selectShowHomeNewProduct" class="item_t"><%=LangRes.Text("HomePageNewProducts") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectShowHomeNewProduct" name="ShowHomeNewProduct" class="select">
                                                        <option value="True" <%=Helper.SELECTED("ShowHomeNewProduct", true, DisplaySetting.ShowHomeNewProduct) %>><%=LangRes.Text("Show") %></option>
                                                        <option value="False" <%=Helper.SELECTED("ShowHomeNewProduct", false, DisplaySetting.ShowHomeNewProduct) %>><%=LangRes.Text("DoNotShow") %></option>
                                                    </select>
                                                </td>
                                                <th class="title"><label for="txtHomeNewProductNumber" class="item_t"><%=LangRes.Text("ShowNumber") %>:</label></th>
                                                <td class="field"><input type="text" id="txtHomeNewProductNumber" name="HomeNewProductNumber" maxlength="3" class="txt" value="<%=DisplaySetting.HomeNewProductNumber %>" /></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label class="item_t"><%=LangRes.Text("HomePageRecommendProductCategories") %>:</label></th>
                                                <td class="field">
                                                    <ul class="cats">
                                                    <% foreach(Category category in RootCategoryList){ %>
                                                        <li class="cat"><label for="HomeProductCategoryIdList_<%=category.CategoryId %>"><input type="checkbox" id="HomeProductCategoryIdList_<%=category.CategoryId %>" name="HomeProductCategoryIdList" value="<%=category.CategoryId %>" <%=Helper.IF(DisplaySetting.HomeProductCategoryIdList.Contains(category.CategoryId), "checked='checked'") %> />&nbsp;<%=category.Name %>(<%=category.UrlName %>)</label></li>
                                                    <% } %>  
                                                        <li class="clear"></li>
                                                    </ul>
                                                </td>
                                                <th class="title"><label for="txtHomeRecommendProductNumber" class="item_t"><%=LangRes.Text("ProductShowNumber") %>：</label></th>
                                                <td class="field"><input type="text" id="txtHomeRecommendProductNumber" name="HomeRecommendProductNumber" maxlength="3" class="txt" value="<%=DisplaySetting.HomeRecommendProductNumber %>" /></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="selectOpenProductComment" class="item_t"><%=LangRes.Text("ProductCommentSwitch") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectOpenProductComment" name="OpenProductComment" class="select">
                                                        <option value="<%=FunctionOpenTypes.Custom %>" <%=Helper.SELECTED("OpenProductComment", FunctionOpenTypes.Custom, DisplaySetting.OpenProductComment) %>><%=LangRes.Text("OpenProductCommentCustomType") %></option>
                                                        <option value="<%=FunctionOpenTypes.ForceOpen %>" <%=Helper.SELECTED("OpenProductComment", FunctionOpenTypes.ForceOpen, DisplaySetting.OpenProductComment) %>><%=LangRes.Text("OpenProductCommentForceOpenType") %></option>
                                                        <option value="<%=FunctionOpenTypes.ForceClose %>" <%=Helper.SELECTED("OpenProductComment", FunctionOpenTypes.ForceClose, DisplaySetting.OpenProductComment) %>><%=LangRes.Text("OpenProductCommentForceCloseType") %></option>
                                                    </select>
                                                </td>

                                                <th class="title"><label for="selectNeedValidateProductComment" class="item_t"><%=LangRes.Text("NeedValidateComment") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectNeedValidateProductComment" name="NeedValidateProductComment" class="select">
                                                        <option value="True" <%=Helper.SELECTED("NeedValidateProductComment", true, DisplaySetting.NeedValidateProductComment) %>><%=LangRes.Text("NeedValidate") %></option>
                                                        <option value="False" <%=Helper.SELECTED("NeedValidateProductComment", false, DisplaySetting.NeedValidateProductComment) %>><%=LangRes.Text("NotNeedValidate") %></option>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtProductListPageSize" class="item_t"><%=LangRes.Text("ProductListPageSize") %>:</label></th>
                                                <td class="field"><input type="text" id="txtProductListPageSize" name="ProductListPageSize" maxlength="3" class="txt" value="<%=DisplaySetting.ProductListPageSize %>" /></td>

                                                <th class="title"><label for="txtProductCommentListPageSize" class="item_t"><%=LangRes.Text("CommentListPageSize") %>:</label></th>
                                                <td class="field"><input type="text" id="txtProductCommentListPageSize" name="ProductCommentListPageSize" maxlength="3" class="txt" value="<%=DisplaySetting.ProductCommentListPageSize %>" /></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtProductListPluginCode" class="item_t"><%=LangRes.Text("ListPagePluginCode") %>:</label></th>
                                                <td class="field" colspan="3"><textarea id="txtProductListPluginCode" name="ProductListPluginCode" class="txt" cols="40" rows="5"><%=DisplaySetting.ProductListPluginCode %></textarea></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtProductDetailPluginCode" class="item_t"><%=LangRes.Text("DetailPagePluginCode") %>:</label></th>
                                                <td class="field" colspan="3"><textarea id="txtProductDetailPluginCode" name="ProductDetailPluginCode" class="txt" cols="40" rows="5"><%=DisplaySetting.ProductDetailPluginCode %></textarea></td>
                                            </tr>

                                        </table>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectOpenArticleModule"><%=LangRes.Text("OpenArticleModule") %>:</label></th>
                                <td class="field" colspan="3">
                                    <div>
                                        <select id="selectOpenArticleModule" name="OpenArticleModule" class="select" onchange="YesOrNoShowOrHide('selectOpenArticleModule', 'ArticleSettingModule');">
                                            <option value="True" <%=Helper.SELECTED("OpenArticleModule", true, DisplaySetting.OpenArticleModule) %>><%=LangRes.Text("OpenTheModule") %></option>
                                            <option value="False" <%=Helper.SELECTED("OpenArticleModule", false, DisplaySetting.OpenArticleModule) %>><%=LangRes.Text("CloseTheModule") %></option>
                                        </select>
                                    </div>

                                    <div id="ArticleSettingModule" class="child_setting_panel">
                                        <table class="editor_table" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th class="title"><label for="selectShowHomeNewArticle" class="item_t"><%=LangRes.Text("HomePageLatestNews") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectShowHomeNewArticle" name="ShowHomeNewArticle" class="select">
                                                        <option value="True" <%=Helper.SELECTED("ShowHomeNewArticle", true, DisplaySetting.ShowHomeNewArticle) %>><%=LangRes.Text("Show") %></option>
                                                        <option value="False" <%=Helper.SELECTED("ShowHomeNewArticle", false, DisplaySetting.ShowHomeNewArticle) %>><%=LangRes.Text("DoNotShow") %></option>
                                                    </select>
                                                </td>

                                                <th class="title"><label for="txtHomeNewArticleNumber" class="item_t"><%=LangRes.Text("ShowNumber") %>:</label></th>
                                                <td class="field"><input type="text" id="txt" name="HomeNewArticleNumber" maxlength="3" class="txt" value="<%=DisplaySetting.HomeNewArticleNumber %>" /></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="selectOpenArticleComment" class="item_t"><%=LangRes.Text("ArticleCommentSwitch") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectOpenArticleComment" name="OpenArticleComment" class="select">
                                                        <option value="<%=FunctionOpenTypes.Custom %>" <%=Helper.SELECTED("OpenArticleComment", FunctionOpenTypes.Custom, DisplaySetting.OpenArticleComment) %>><%=LangRes.Text("OpenArticleCommentCustomType") %></option>
                                                        <option value="<%=FunctionOpenTypes.ForceOpen %>" <%=Helper.SELECTED("OpenArticleComment", FunctionOpenTypes.ForceOpen, DisplaySetting.OpenArticleComment) %>><%=LangRes.Text("OpenArticleCommentForceOpenType") %></option>
                                                        <option value="<%=FunctionOpenTypes.ForceClose %>" <%=Helper.SELECTED("OpenArticleComment", FunctionOpenTypes.ForceClose, DisplaySetting.OpenArticleComment) %>><%=LangRes.Text("OpenArticleCommentForceCloseType") %></option>
                                                    </select>
                                                </td>

                                                <th class="title"><label for="selectNeedValidateArticleComment" class="item_t"><%=LangRes.Text("NeedValidateComment") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectNeedValidateArticleComment" name="NeedValidateArticleComment" class="select">
                                                        <option value="True" <%=Helper.SELECTED("NeedValidateArticleComment", true, DisplaySetting.NeedValidateArticleComment) %>><%=LangRes.Text("NeedValidate") %></option>
                                                        <option value="False" <%=Helper.SELECTED("NeedValidateArticleComment", false, DisplaySetting.NeedValidateArticleComment) %>><%=LangRes.Text("NotNeedValidate") %></option>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtArticleListPageSize" class="item_t"><%=LangRes.Text("ArticleListPageSize") %>:</label></th>
                                                <td class="field"><input type="text" id="txtArticleListPageSize" name="ArticleListPageSize" maxlength="3" class="txt" value="<%=DisplaySetting.ArticleListPageSize %>" /></td>

                                                <th class="title"><label for="txtArticleCommentListPageSize" class="item_t"><%=LangRes.Text("CommentListPageSize") %></label></th>
                                                <td class="field"><input type="text" id="txtArticleCommentListPageSize" name="ArticleCommentListPageSize" maxlength="3" class="txt" value="<%=DisplaySetting.ArticleCommentListPageSize %>" /></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtArticleListPluginCode" class="item_t"><%=LangRes.Text("ListPagePluginCode") %>:</label></th>
                                                <td class="field" colspan="3"><textarea id="txtArticleListPluginCode" name="ArticleListPluginCode" class="txt" cols="40" rows="5"><%=DisplaySetting.ArticleListPluginCode %></textarea></td>
                                            </tr>

                                            <tr>
                                                <th class="title"><label for="txtArticleDetailPluginCode" class="item_t"><%=LangRes.Text("DetailPagePluginCode") %>:</label></th>
                                                <td class="field" colspan="3"><textarea id="txtArticleDetailPluginCode" name="ArticleDetailPluginCode" class="txt" cols="40" rows="5"><%=DisplaySetting.ArticleDetailPluginCode %></textarea></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectOpenMessageBoard"><%=LangRes.Text("OpenMessageBoardModule") %>:</label></th>
                                <td class="field" colspan="3">
                                    <div>
                                        <select id="selectOpenMessageBoard" name="OpenMessageBoard" class="select" onchange="YesOrNoShowOrHide('selectOpenMessageBoard', 'MessageBoardSettingModule');">
                                            <option value="True" <%=Helper.SELECTED("OpenMessageBoard", true, DisplaySetting.OpenMessageBoard) %>><%=LangRes.Text("OpenTheModule") %></option>
                                            <option value="False" <%=Helper.SELECTED("OpenMessageBoard", false, DisplaySetting.OpenMessageBoard) %>><%=LangRes.Text("CloseTheModule") %></option>
                                        </select>
                                    </div>

                                    <div id="MessageBoardSettingModule" class="child_setting_panel">
                                        <table class="editor_table" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th class="title"><label for="selectNeedValidateMessageBoardComment" class="item_t"><%=LangRes.Text("NeedValidateCommentMessage") %>:</label></th>
                                                <td class="field">
                                                    <select id="selectNeedValidateMessageBoardComment" name="NeedValidateMessageBoardComment" class="select">
                                                        <option value="True" <%=Helper.SELECTED("NeedValidateMessageBoardComment", true, DisplaySetting.NeedValidateMessageBoardComment) %>><%=LangRes.Text("NeedValidate") %></option>
                                                        <option value="False" <%=Helper.SELECTED("NeedValidateMessageBoardComment", false, DisplaySetting.NeedValidateMessageBoardComment) %>><%=LangRes.Text("NotNeedValidate") %></option>
                                                    </select>
                                                </td>

                                                <th class="title"><label for="txtMessageBoardCommentListPageSize" class="item_t"><%=LangRes.Text("CommentMessageListPageSize") %>:</label></th>
                                                <td class="field"><input type="text" id="txtMessageBoardCommentListPageSize" name="MessageBoardCommentListPageSize" maxlength="3" class="txt" value="<%=DisplaySetting.MessageBoardCommentListPageSize %>" /></td>
                                            </tr>
                                            <tr>
                                                <th class="title"><label for="txtMessageBoardContent" class="item_t"><%=LangRes.Text("MessageBoardPageContent") %>:</label></th>
                                                <td class="field" colspan="3">
                                                    <textarea id="txtMessageBoardContent" name="MessageBoardContent" class="txt" cols="55" rows="8"><%=DisplaySetting.MessageBoardContent %></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>

                            
                            <tr>
                                <th class="title"><label for="txtGlobalAppendCode"><%=LangRes.Text("GlobalAppendCode") %>:</label></th>
                                <td class="field" colspan="3"><textarea id="txtGlobalAppendCode" name="GlobalAppendCode" class="txt" cols="55" rows="5"><%=DisplaySetting.GlobalAppendCode %></textarea></td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtHomePluginCode"><%=LangRes.Text("HomePagePluginCode") %>:</label></th>
                                <td class="field" colspan="3"><textarea id="txtHomePluginCode" name="HomePluginCode" class="txt" cols="55" rows="5"><%=DisplaySetting.HomePluginCode %></textarea></td>
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
    <script type="text/javascript">
        $(function () {
            YesOrNoShowOrHide('selectShowGoogleTranslatorTool', 'GoogleTranslatorToolConfigPanel');

            YesOrNoShowOrHide('selectOpenHomeSlider', 'linkSliderManagerPage');
            YesOrNoShowOrHide('selectCustomizeMainNavigation', 'linkNavManagerPage');

            YesOrNoShowOrHide('selectOpenTopicModule', 'TopicModuleSettingPanel');
            YesOrNoShowOrHide('selectOpenProductModule', 'ProductSettingModule');
            YesOrNoShowOrHide('selectOpenArticleModule', 'ArticleSettingModule');

            YesOrNoShowOrHide('selectOpenMessageBoard', 'MessageBoardSettingModule');

            SelectSkin();

            InitEditor('txtMessageBoardContent');

        });
    </script>
</body>
</html>
