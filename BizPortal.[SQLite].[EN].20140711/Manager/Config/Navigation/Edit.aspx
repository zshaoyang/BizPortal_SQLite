<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.EditNavigationPage" ValidateRequest="false" %>

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
                    <strong><%=LangRes.Text("UpdateNavMenuData") %></strong>
                    <span><a href="<%=ADMIN_URL("NavManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("AddNavPage") %>" class="more_link"><%=LangRes.Text("AddNavMenuData") %>+</a></span>
                    <span><a href="<%=ADMIN_URL("DisplayConfigPage") %>" class="more_link"><%=LangRes.Text("DisplaySetting") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=221" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <td class="field" style="width:35%;"><input type="text" id="txtName" name="Name" class="txt" maxlength="250" value="<%=TheNavMenu.Name %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtTitle" name="Title" class="txt" maxlength="250" value="<%=TheNavMenu.Title %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("Link") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtLink" name="Link" class="txt" maxlength="250" value="<%=TheNavMenu.Link %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSortOrder" name="SortOrder" class="txt" maxlength="3" value="<%=TheNavMenu.SortOrder %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectParentMenuId"><%=LangRes.Text("ParentNavigation") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectParentMenuId" name="ParentMenuId" class="select">
                                        <option value="0"><%=LangRes.Text("RootLevelNavigation") %></option>
                                    <% foreach(NavMenu menu in RootNavMenuList){ %>
                                        <option value="<%=menu.MenuId %>" <%=Helper.SELECTED("ParentMenuId", menu.MenuId, TheNavMenu.ParentMenuId) %>><%=menu.Name %></option>
                                    <% } %>
                                    </select>
                                </td>

                                <th class="title" style="width:15%;"><label for="selectPosition"><%=LangRes.Text("Position") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectPosition" name="Position" class="select">
                                    <%  foreach (string name in Enum.GetNames(typeof(NavMenuPosition))){  %>
                                        <option value="<%=name %>" <%=Helper.SELECTED("Position", name, TheNavMenu.Position) %>><%=LangRes.Text(name + "Menu") %></option>
                                    <%  }  %>
                                    </select>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="hidden" id="MenuId" name="MenuId" value="<%=TheNavMenu.MenuId %>" />
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("UpdateNavMenuData") %>" class="submit" />
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
</body>
</html>
