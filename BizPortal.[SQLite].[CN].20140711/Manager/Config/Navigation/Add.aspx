<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AddNavigationPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("AddNavMenuData") %></strong>
                    <span><a href="<%=ADMIN_URL("NavManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("DisplayConfigPage") %>" class="more_link"><%=LangRes.Text("DisplaySetting") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=220" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:15%;"><label for="txtName"><%=LangRes.Text("Name") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtName" name="Name" class="txt" maxlength="250" /></td>

                                <th class="title" style="width:15%;"><label for="txtTitle"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtTitle" name="Title" class="txt" maxlength="250" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtLink"><%=LangRes.Text("Link") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtLink" name="Link" class="txt" maxlength="250" /></td>

                                <th class="title" style="width:15%;"><label for="txtSortOrder"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSortOrder" name="SortOrder" class="txt" maxlength="3" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectParentMenuId"><%=LangRes.Text("ParentNavigation") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectParentMenuId" name="ParentMenuId" class="select">
                                        <option value="0"><%=LangRes.Text("RootLevelNavigation") %></option>
                                    <% foreach(NavMenu menu in RootNavMenuList){ %>
                                        <option value="<%=menu.MenuId %>"><%=menu.Name %></option>
                                    <% } %>
                                    </select>
                                </td>

                                <th class="title" style="width:15%;"><label for="selectPosition"><%=LangRes.Text("Position") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectPosition" name="Position" class="select">
                                    <%  foreach (string name in Enum.GetNames(typeof(NavMenuPosition))){  %>
                                        <option value="<%=name %>"><%=LangRes.Text(name + "Menu") %></option>
                                    <%  }  %>
                                    </select>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("AddNavMenuData") %>" class="submit" />
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    </form>
                </div>
            </div>
        </div>

<!-- #include file="../../includes/_footer.html" -->

    </div>
    <script type="text/javascript">
        $(function(){
            var TextTips = new FormTextTip({
                "txtName": "<%=LangRes.Text("NameForShow") %>",
                "txtTitle": "<%=LangRes.Text("TitleForMouseHover") %>",
                "txtLink": "<%=LangRes.Text("ClickToRedirectLink") %>",
                "txtSortOrder": "<%=LangRes.Text("ValueMoreLessPriorityHigher") %>"
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
