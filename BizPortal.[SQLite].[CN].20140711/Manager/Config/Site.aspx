<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.SiteSettingPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("SiteSetting") %></strong>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=100" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:15%;"><label for="txtSiteName"><%=LangRes.Text("SiteName") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSiteName" name="SiteName" class="txt" maxlength="100" value="<%=SiteSetting.SiteName %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtSiteTitle"><%=LangRes.Text("SiteTitle") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSiteTitle" name="SiteTitle" class="txt" maxlength="100" value="<%=SiteSetting.SiteTitle %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtSiteHeadSignature"><%=LangRes.Text("SiteHeadSignature") %>:</label></th>
                                <td class="field" style="width:35%;" colspan="3"><input type="text" id="txtSiteHeadSignature" name="SiteHeadSignature" class="txt" maxlength="250" value="<%=SiteSetting.SiteHeadSignature %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtSiteKeywords"><%=LangRes.Text("SiteKeywords") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSiteKeywords" name="SiteKeywords" class="txt" maxlength="200" value="<%=SiteSetting.SiteKeywords %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtSiteDescription"><%=LangRes.Text("SiteDescription") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSiteDescription" name="SiteDescription" class="txt" maxlength="200" value="<%=SiteSetting.SiteDescription %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtGovRecord"><%=LangRes.Text("SiteGovRecord") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtGovRecord" name="GovRecord" class="txt" maxlength="100" value="<%=SiteSetting.GovRecord %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtCopyright"><%=LangRes.Text("CompanyCopyright") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtCopyright" name="Copyright" class="txt" maxlength="250" value="<%=SiteSetting.Copyright %>" /></td>

                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtSiteCountCode"><%=LangRes.Text("SiteCountCode") %>:</label></th>
                                <td class="field" style="width:35%;" colspan="3"><textarea id="txtSiteCountCode" name="SiteCountCode" class="txt" rows="4" cols="55"><%=SiteSetting.SiteCountCode %></textarea></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectOpenEmailContact"><%=LangRes.Text("OpenEmailContactFunction") %>:</label></th>
                                <td class="field" style="width:35%;" colspan="3">
                                    <div>
                                        <select id="selectOpenEmailContact" name="OpenEmailContact" class="select" onchange="YesOrNoShowOrHide('selectOpenEmailContact', 'SmtpSettingPanel');">
                                            <option value="True" <%=Helper.SELECTED("OpenEmailContact", true, SiteSetting.OpenEmailContact) %>><%=LangRes.Text("OpenTheFunction") %></option>
                                            <option value="False" <%=Helper.SELECTED("OpenEmailContact", false, SiteSetting.OpenEmailContact) %>><%=LangRes.Text("CloseTheFunction") %></option>
                                        </select>
                                    </div>

                                    <div id="SmtpSettingPanel" class="child_setting_panel">
                                        <table class="editor_table" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th class="title"><label for="txtSmtpHost" class="item_t"><%=LangRes.Text("SmtpHost") %>:</label></th>
                                                <td class="field"><input type="text" id="txtSmtpHost" name="SmtpHost" maxlength="200" class="txt" value="<%=SiteSetting.SmtpHost %>" /></td>
                                                <th class="title"><label for="txtSmtpHostPort" class="item_t"><%=LangRes.Text("SmtpHostPort") %>:</label></th>
                                                <td class="field"><input type="text" id="txtSmtpHostPort" name="SmtpHostPort" maxlength="7" class="txt" value="<%=SiteSetting.SmtpHostPort %>" /></td>
                                            </tr>
                                            <tr>
                                                <th class="title"><label for="txtSmtpAccount" class="item_t"><%=LangRes.Text("SmtpAccount") %>:</label></th>
                                                <td class="field"><input type="text" id="txtSmtpAccount" name="SmtpAccount" maxlength="200" class="txt" value="<%=SiteSetting.SmtpAccount %>" /></td>
                                                <th class="title"><label for="txtSmtpPassword" class="item_t"><%=LangRes.Text("SmtpPassword") %>:</label></th>
                                                <td class="field"><input type="password" id="txtSmtpPassword" name="SmtpPassword" maxlength="200" class="txt" /></td>
                                            </tr>
                                            <tr>
                                                <th class="title"><label for="txtMasterName" class="item_t"><%=LangRes.Text("SiteMasterName") %>:</label></th>
                                                <td class="field"><input type="text" id="txtMasterName" name="MasterName" class="txt" maxlength="30" value="<%=SiteSetting.MasterName %>" /></td>

                                                <th class="title"><label for="txtMasterEmail" class="item_t"><%=LangRes.Text("SiteMasterEmail") %>:</label></th>
                                                <td class="field"><input type="text" id="txtMasterEmail" name="MasterEmail" class="txt" maxlength="200" value="<%=SiteSetting.MasterEmail %>" /></td>
                                            </tr>
                                        </table>
                                    </div>
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
            YesOrNoShowOrHide('selectOpenEmailContact', 'SmtpSettingPanel');

            var TextTips = new FormTextTip({
                "txtSiteHeadSignature": "<%=LangRes.Text("SiteHeadSignatureNote") %>",
                "txtSiteKeywords": "<%=LangRes.Text("SiteKeywordsNote") %>",
                "txtSiteDescription": "<%=LangRes.Text("SiteDescriptionNote") %>",
                "txtCopyright": "<%=LangRes.Text("CompanyCopyrightNote") %>",
                "txtSiteCountCode": "<%=LangRes.Text("SiteCountCodeNote") %>"
            }, "txt_tip");

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
