<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.NavigationPage" %>

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
                    <strong><%=LangRes.Text("ManageNavMenuData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddNavPage") %>" class="more_link"><%=LangRes.Text("AddNavMenuData") %>+</a></span>
                    <span><a href="<%=ADMIN_URL("DisplayConfigPage") %>" class="more_link"><%=LangRes.Text("DisplaySetting") %></a></span>
                </div>
                <div class="main_content">
                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                    <table class="list_table menu_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th><%=LangRes.Text("Name") %></th>
                                <th><%=LangRes.Text("Title") %></th>
                                <th><%=LangRes.Text("Link") %></th>
                                <th><%=LangRes.Text("Position") %></th>
                                <th><%=LangRes.Text("SortOrder") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach (NavMenu menu in RootNavMenuList)
                            {
                        %>
                            <tr class="root" id="menuItem_<%=menu.MenuId %>">
                                <td><%=menu.MenuId %></td>
                                <td class="name"><%=menu.Name %></td>
                                <td><%=menu.Title %></td>
                                <td><a href="<%=menu.Link %>" target="_blank"><%=menu.Link %></a></td>
                                <td><%=LangRes.Text(menu.Position + "Menu") %></td>
                                <td><%=menu.SortOrder %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditNavPage", menu.MenuId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteMenu_<%=menu.MenuId %>" class="btn_delete_menu" href="<%=API_URL("AdminConfigHandler") %>?action=222&MenuId=<%=menu.MenuId %>"><%=LangRes.Text("Delete") %></a>
                                </td>
                            </tr>
                            <% 
                            if(menu.ChildMenuList != null && menu.ChildMenuList.Count > 0){    
                                foreach(NavMenu childMenu in menu.ChildMenuList){
                            %>
                                <tr class="level2" id="Tr1">
                                    <td><%=childMenu.MenuId %></td>
                                    <td class="name"><%=childMenu.Name %></td>
                                    <td><%=childMenu.Title %></td>
                                    <td><a href="<%=childMenu.Link %>" target="_blank"><%=childMenu.Link %></a></td>
                                    <td><%=LangRes.Text(childMenu.Position + "Menu") %></td>
                                    <td><%=childMenu.SortOrder %></td>
                                    <td>
                                        <a href="<%=ADMIN_URL("EditNavPage", childMenu.MenuId) %>"><%=LangRes.Text("Edit") %></a>
                                        &nbsp;
                                        <a id="btnDeleteMenu_<%=childMenu.MenuId %>" class="btn_delete_menu" href="<%=API_URL("AdminConfigHandler") %>?action=222&MenuId=<%=childMenu.MenuId %>"><%=LangRes.Text("Delete") %></a>
                                    </td>
                                </tr>
                            <%
                                }
                            } 
                            %>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="7">&nbsp;</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

<!-- #include file="../../includes/_footer.html" -->

    </div>
    <script type="text/javascript">
        $(function(){
            $("td .btn_delete_menu").each(function () {
                var btn = $(this);
                var btnId = btn.attr("id");

                btn.bind("click", function () {

                    QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheNavMenu") %>", function (jsonData) {
                        var actionResult = parseInt(jsonData["Result"]);
                        var menuId = jsonData["Data"];
                        var menuItem = $("#menuItem_" + menuId);

                        menuItem.fadeOut(400);
                        setTimeout(function () {
                            menuItem.remove();
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
