<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AdminSettingPage" %>

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
                    <strong><%=LangRes.Text("AdminSetting") %></strong>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=300" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("AccountName") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtAccount" name="Account" class="txt" maxlength="100" value="<%=AdminSetting.Account %>" /></td>

                                <th class="title" style="width:15%;">&nbsp;</th>
                                <td class="field" style="width:35%;">&nbsp;</td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtPassword"><%=LangRes.Text("NewPassword") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <input type="text" id="txtPassword" name="Password" class="txt" maxlength="100" />
                                    <br /><span class="desc"><%=LangRes.Text("SetNewPasswordNotModifyThenEmpty") %></span>
                                </td>

                                <th class="title" style="width:15%;"><label for="txtOriginalPassword"><%=LangRes.Text("OriginalPassword") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <input type="text" id="txtOriginalPassword" name="OriginalPassword" class="txt" maxlength="100" />
                                    <br /><span class="desc"><%=LangRes.Text("ConfirmOldPasswordToSetNew") %></span>
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
            var TextTips = new FormTextTip({
                "txtAccount": "<%=LangRes.Text("AccountForAdminLogin") %>"
            }, "txt_tip");

            <%if(ActionResult.Data != null){%>
            var TempCategoryJson = <%=ActionResult.Data %>;
            $("#txtAccount").val(TempCategoryJson["Account"]);

            <%}%>

        });
    </script>
</body>
</html>
