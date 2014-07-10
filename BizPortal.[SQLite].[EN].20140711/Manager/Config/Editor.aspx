<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.EditorSettingPage" ValidateRequest="false" %>

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
                    <strong><%=LangRes.Text("EditorSetting") %></strong>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=400" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:20%;"><label for="selectDirectoryName"><%=LangRes.Text("EditorDirectoryName") %>:</label></th>
                                <td class="field" style="width:30%;">
                                    <select id="selectDirectoryName" name="DirectoryName" class="select" onchange="LoadEditorConfig('<%=API_URL("AdminConfigHandler") %>?action=401&Directory=' + $('#selectDirectoryName').val());">
                                    <% foreach(KeyValuePair<string, EditorSetting> editorItem in AllEditors){ %>
                                        <option value="<%=editorItem.Value.DirectoryName %>" <%=Helper.SELECTED("DirectoryName", editorItem.Value.DirectoryName, EditorSetting.DirectoryName) %>><%=editorItem.Value.DirectoryName %></option>
                                    <% } %>
                                    </select>
                                </td>

                                <th class="title" style="width:15%;"><label for="txtFileName"><%=LangRes.Text("EditorJsFileName") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtFileName" name="FileName" value="<%=EditorSetting.FileName %>" class="txt" /></td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtInitCode"><%=LangRes.Text("EditorJsInitCode") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtInitCode" name="InitCode" class="txt" rows="4" cols="55"><%=EditorSetting.InitCode %></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtInsertHtmlCode"><%=LangRes.Text("EditorJsInsertHtmlCode") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtInsertHtmlCode" name="InsertHtmlCode" class="txt" rows="4" cols="55"><%=EditorSetting.InsertHtmlCode %></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtGetHtmlCode"><%=LangRes.Text("EditorJsGetHtmlCode") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtGetHtmlCode" name="GetHtmlCode" class="txt" rows="4" cols="55"><%=EditorSetting.GetHtmlCode %></textarea>
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
</body>
</html>
