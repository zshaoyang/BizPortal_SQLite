<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.TopicPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/topic-min.js?v=20131225"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageTopicData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddTopicPage") %>" class="more_link"><%=LangRes.Text("AddTopicData") %>+</a></span>
                </div>
                <div class="main_content">
                    <div class="search_panel">
                        <form id="SearchForm" name="SearchForm" action="<%=ADMIN_URL("TopicManagerPage") %>" method="post">
                            <div id="basic_search_condition_container">
                                <table class="search_table" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <th style=""><label for="SearchKeywords"><%=LangRes.Text("SearchKeywords") %></label></th>
                                        <td style="width:25%;"><input type="text" id="SearchKeywords" name="Keywords" value="<%=SearchFilter.Keywords %>" class="txt" /></td>
                                        <th style=""><label for="SearchChannelId"><%=LangRes.Text("TopicChannel") %></label></th>
                                        <td style="width:25%;">
                                            <select id="SearchChannelId" name="ChannelId" class="select">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                            <% foreach(Channel channel in AllChannelList){ %>
                                                <option value="<%=channel.ChannelId %>" <%=Helper.SELECTED("ChannelId", channel.ChannelId, SearchFilter.ChannelId) %>><%=channel.Name %></option>
                                            <% } %>
                                            </select>
                                        </td>
                                        <th style=""><label for="SearchEnableComment"><%=LangRes.Text("EnableComment") %></label></th>
                                        <td style="width:25%;">
                                            <select id="SearchEnableComment" name="EnableComment" class="select">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                                <option value="True" <%=Helper.SELECTED("EnableComment", true, SearchFilter.EnableComment) %>><%=LangRes.Text("Yes") %></option>
                                                <option value="False" <%=Helper.SELECTED("EnableComment", false, SearchFilter.EnableComment) %>><%=LangRes.Text("No") %></option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div class="search_submit">
                                <input type="submit" id="SubmitSearch" name="SubmitSearch" value="<%=LangRes.Text("Search") %>" class="submit" />
                            </div>
                        </form>
                    </div>

                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                    <form id="ManageForm" action="<%=API_URL("AdminTopicHandler") %>?action=103" method="post" enctype="application/x-www-form-urlencoded">
                    <table class="list_table topic_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th style="width:50px;vertical-align:middle;"><input type="checkbox" id="CheckAll" onclick="CheckAllItems('CheckAll', 'TopicIds', 'CheckAll2');" />&nbsp;<label for="CheckAll">ID</label></th>
                                <th style="width:200px;"><%=LangRes.Text("Title") %></th>
                                <th style="width:100px;"><%=LangRes.Text("Channel") %></th>
                                <th style="width:100px;"><%=LangRes.Text("URLAddress") %></th>
                                <th><%=LangRes.Text("CreateTime") %></th>
                                <th><%=LangRes.Text("CommentCount") %></th>
                                <th style="width:100px;">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach(Topic topic in TopicPageList)
                            {
                                SetTopicChannel(topic);
                        %>
                            <tr id="topicItem_<%=topic.TopicId %>">
                                <td><input type="checkbox" id="TopicIds_<%=topic.TopicId %>" name="TopicIds" value="<%=topic.TopicId %>" />&nbsp;<label for="TopicIds_<%=topic.TopicId %>"><%=topic.TopicId %></label></td>
                                <td><a href="<%=ADMIN_URL("EditTopicPage", topic.TopicId) %>"><%=Helper.HIGHLIGHT(topic.Title, SearchFilter.Keywords) %></a></td>
                                <td>
                                    <div class="three_categories">
                                    <% if(topic.Channel != null){ %>
                                        <a href="<%=ADMIN_URL("EditTopicChannelPage", topic.Channel.ChannelId) %>"><%=topic.Channel.Name %></a>
                                    <% } %>
                                        <div class="clear"></div>
                                    </div>
                                </td>
                                <td>
                                    <a href="<%=URL("TopicDetailPage", topic.UrlName) %>" target="_blank"><%=HostURL %><%=URL("TopicDetailPage", topic.UrlName) %></a>
                                </td>
                                <td><%=Helper.DATETIME(topic.CreateTime) %></td>
                                <td><%=topic.TotalComment %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditTopicPage", topic.TopicId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteTopic_<%=topic.TopicId %>" class="btn_delete_topic" href="<%=API_URL("AdminTopicHandler") %>?action=102&TopicId=<%=topic.TopicId %>"><%=LangRes.Text("Delete") %></a>
                                </td>
                            </tr>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="7">
                                    <div class="tool_panel fl">
                                        <input type="checkbox" id="CheckAll2" onclick="CheckAllItems('CheckAll2', 'TopicIds', 'CheckAll');" />&nbsp;<input id="SubmitDeleteChecked" type="submit" value="<%=LangRes.Text("DeleteSelected") %>" class="btn" onclick="    return DeleteTopics('ManageForm', '<%=LangRes.Text("ConfirmToDeleteSelectedTopicData") %>');" />
                                    </div>
                                    <div class="fl">
<% CurrentPager = TopicPager; %>
<!-- #include file="../includes/_pager.html" -->
                                    </div>
                                    <div class="clear"></div>
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
            $("td .btn_delete_topic").each(function () {
                var btn = $(this);
                var btnId = btn.attr("id");

                btn.bind("click", function () {

                    QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheTopic") %>", function (jsonData) {
                        var actionResult = parseInt(jsonData["Result"]);
                        var topicId = jsonData["Data"];
                        var topicItem = $("#topicItem_" + topicId);

                        topicItem.fadeOut(400);
                        setTimeout(function () {
                            topicItem.remove();
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
