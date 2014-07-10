<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.ChannelPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/topic-min.js?v=20131227"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageTopicChannelData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddTopicChannelPage") %>" class="more_link"><%=LangRes.Text("AddTopicChannelData") %>+</a></span>
                </div>
                <div class="main_content">
                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                    <table class="list_table channel_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th><%=LangRes.Text("ChannelName") %></th>
                                <th><%=LangRes.Text("SEOKeywords") %></th>
                                <th><%=LangRes.Text("SEODescription") %></th>
                                <th><%=LangRes.Text("SortOrder") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach (Channel channel in AllChannelList)
                            {
                        %>
                            <tr id="channelItem_<%=channel.ChannelId %>">
                                <td><%=channel.ChannelId %></td>
                                <td><a href="<%=ADMIN_URL("EditTopicChannelPage", channel.ChannelId) %>"><%=channel.Name %></a></td>
                                <td><%=channel.Keywords %></td>
                                <td><%=channel.Description %></td>
                                <td><%=channel.SortOrder %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditTopicChannelPage", channel.ChannelId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteChannel_<%=channel.ChannelId %>" class="btn_delete_channel" href="<%=API_URL("AdminChannelHandler") %>?action=102&ChannelId=<%=channel.ChannelId %>"><%=LangRes.Text("Delete") %></a>
                                </td>
                            </tr>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="6">&nbsp;</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

<!-- #include file="../includes/_footer.html" -->

    </div>

    <script type="text/javascript">
        $(".channel_list td .btn_delete_channel").each(function () {
            var btn = $(this);
            var btnId = btn.attr("id");

            btn.bind("click", function () {
                QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheTopicChannel") %>", function (jsonData) {
                    var actionResult = parseInt(jsonData["Result"]);
                    var channelId = jsonData["Data"];
                    var channelItem = $("#channelItem_" + channelId);

                    channelItem.fadeOut(400);
                    setTimeout(function () {
                        channelItem.remove();
                    }, 500);

                    return true;
                });

                return false;
            });
        });
    </script>
</body>
</html>
