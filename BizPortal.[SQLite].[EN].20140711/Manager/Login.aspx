<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.LoginPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title><%=PageTitle %></title>

    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery/jquery.cookie.min.js"></script>
    <script type="text/javascript" src="<%=WebRoot %>Scripts/sleeping-tiger-lib/sleeping-tiger-lib-min.js?v=20131224"></script>
    <link href="<%=AdminRoot %>css/login.css?v=20140109" type="text/css" rel="Stylesheet" />
</head>
<body>

    <div id="login_body">
        <div id="login_div">
            <div id="login_form_top_div">
                <div id="login_form_bottom_div">
                    <div id="login_form_div">
                        <form id="login_form" name="login_form" action="<%=ADMIN_URL("LoginPage") %>?__BackUrl=<%=BackUrl %>" method="post">
                        <table id="login_table" border="0" cellpadding="0" cellspacing="0">
                            <tbody>
                                <tr>
                                    <td align="right" valign="middle" style="text-align:right;" class="fields">
                                        <label for="AccountName">
                                            <span><%=LangRes.Text("Username") %></span>
                                            <input type="text" id="AccountName" class="input width_150" name="AccountName" />
                                        </label>
                                        <label for="Password">
                                            <span><%=LangRes.Text("Password") %></span>
                                            <input type="password" id="Password" class="input width_150" name="Password" />
                                        </label>
                                    </td>
                                    <td align="left" valign="middle" style="text-align:left;">
                                        <input type="submit" class="login_btn" id="SubmitLogin" name="SubmitLogin" onclick="return SubmitAdminLogin();" value="&nbsp;" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="login_footer"><a href="<%=AppInfo.Link %>" target="_blank"><%=AppInfo.AppName %>&nbsp; <%=AppInfo.Edition %><%=AppInfo.Version %></a>&nbsp;&nbsp;<%=AppInfo.Copyright %></div>
    </div>


    <script type="text/javascript" src="<%=AdminRoot %>js/login-min.js?v=20140109"></script>
</body>
</html>
