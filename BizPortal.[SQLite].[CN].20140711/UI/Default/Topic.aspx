<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.TopicDetailPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/topic.css?v=<%=AppInfo.Build %>" />
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/comment.css?v=<%=AppInfo.Build %>" />
</head>
<body id="body">
    
<!-- #include file="includes/_head.html" -->

    <div id="position">
        <a href="<%=URL("HomePage") %>"><%=LangRes.Get("HomePage") %></a>
        <em>/</em>
        <% if (TheTopic.Channel != null){ %>
        <a href="<%=URL("TopicDetailPage", TheTopic.Channel.FirstTopic.UrlName) %>"><%=TheTopic.Channel.Name %></a>
        <em>/</em>
        <%} %>
        <span><%=TheTopic.Title %></span>
    </div>

    <div id="content">
        <div id="topic_panel" class="<%=Helper.IF(BlockSetting.IsSetTopicDetailPageBlock || (TheTopic.Channel != null && TopicList.Count > 1),"small") %>">
            <h2><%=TheTopic.Title %></h2>

            <div id="text_content">
                <%=TheTopic.Content %>
            </div>

            <% if (DisplaySetting.OpenTopicComment == FunctionOpenTypes.ForceOpen || TheTopic.EnableComment || SiteSetting.OpenEmailContact) { %>
            <div id="post_comment_panel" class="panel">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                    <% if (DisplaySetting.OpenTopicComment == FunctionOpenTypes.ForceOpen || TheTopic.EnableComment) { %>
                        <a href="javascript:void(0);" class="title comment_menu" data="comment_list_box"><%=LangRes.Get("CommentList") %></a>
                        <a href="javascript:void(0);" class="title comment_menu" data="post_comment_box"><%=LangRes.Get("PostComment") %></a>
                    <% } %>
                    <% if (SiteSetting.OpenEmailContact) { %>
                        <a href="javascript:void(0);" class="title comment_menu" data="post_email_box"><%=LangRes.Get("EmailContact") %></a>
                    <% } %>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                
                <% if (DisplaySetting.OpenTopicComment == FunctionOpenTypes.ForceOpen || TheTopic.EnableComment) { %>
                <div class="panel_box comment_panel_item post_comment_panel" id="comment_list_box">
                    <div class="panel_box_inner">
                        <ul class="comment_list">
                        <% for (int i = 0; i < CommentPageList.Count; i++ )
                           {
                               Comment comment = CommentPageList[i];
                               int layer = CommentPager.RecordCount - (CommentPager.PageIndex - 1) * CommentPager.PageSize - i;
                        %>
                            <li class="comment_item<%=Helper.IF(i % 2 == 0, " alt") %>">
                                <div class="comment_title">
                                    <h5>
                                        <a class="layer" href="#Comment_<%=layer %>">#<%=string.Format(LangRes.Get("Floor"), layer) %></a>
                                        <a id="Comment_<%=layer %>" name="Comment_<%=layer %>"></a>
                                        <%=comment.AuthorName%>
                                    </h5>
                                    <span class="info"><%=Helper.DATETIME(comment.CreateTime)%></span>
                                </div>
                                <div class="comment_body"><%=comment.Content%></div>
                                <% if(comment.ReplyTime.Date != DateTime.MinValue.Date){ %>
                                <div class="comment_reply">
                                    <div class="comment_title">
                                        <h5><%=LangRes.Get("AdminReply") %>:</h5>
                                        <span class="info"><%=Helper.DATETIME(comment.ReplyTime)%></span>
                                    </div>
                                    <div class="comment_body"><%=comment.ReplyContent%></div>
                                </div>
                                <% } %>
                            </li>
                        <% } %>
                        </ul>

<% CurrentPager = CommentPager; %>
<!-- #include file="includes/_pager.html" -->
                    </div>
                </div>

                <div class="panel_box comment_panel_item post_comment_panel" id="post_comment_box">
                    <div class="panel_box_inner">
                    <form id="PostCommentForm" action="<%=API_URL("OperationHandler") %>?action=100" method="post" enctype="application/x-www-form-urlencoded">
                        <div class="author_name">
                            <label for="txtAuthorName"><%=LangRes.Get("YourName") %>:</label>
                            <input type="text" id="txtAuthorName" name="AuthorName" class="txt" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="author_email">
                            <label for="txtAuthorEmail"><%=LangRes.Get("EmailAddress") %>:</label>
                            <input type="text" id="txtAuthorEmail" name="AuthorEmail" class="txt" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="comment_content">
                            <textarea id="txtContent" name="Content" class="txt" cols="55" rows="6"></textarea>
                            <span style="color:red;">*</span>
                        </div>
                        <div id="ActionMessageBox" class="comment_content action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                        <div class="post_submit">
                            <input type="hidden" id="BelongType" name="BelongType" value="<%=CommentBelongTypes.Topic %>" />
                            <input type="hidden" id="TargetId" name="TargetId" value="<%=TheTopic.TopicId %>" />
                            <input type="submit" id="SubmitComment" name="SubmitComment" class="submit" value="<%=LangRes.Get("SubmitComment") %>" onclick="SubmitPostCommentForm('PostCommentForm', 'SubmitComment'); return false;" />
                        </div>
                    </form>
                    </div>
                </div>
                <% } %>

                <% if(SiteSetting.OpenEmailContact){ %>
                <div class="panel_box comment_panel_item post_comment_panel" id="post_email_box">
                    <div class="panel_box_inner">
                    <form id="PostEmailForm" action="<%=API_URL("OperationHandler") %>?action=200" method="post" enctype="application/x-www-form-urlencoded">
                        <div class="post_title">
                            <label for="txtEmailTitle"><%=LangRes.Get("EmailTitle") %>:</label>
                            <input type="text" id="txtEmailTitle" name="EmailTitle" class="txt" value="<%=string.Format(LangRes.Get("AboutTopic"), TheTopic.Title) %>" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="author_name">
                            <label for="txtEmailSender"><%=LangRes.Get("YourName") %>:</label>
                            <input type="text" id="txtEmailSender" name="EmailSender" class="txt" />
                            <span style="color:red;">*</span>
                        </div>
                        <div class="comment_content">
                            <textarea id="txtEmailContent" name="EmailContent" class="txt" cols="55" rows="6"></textarea>
                            <span style="color:red;">*</span>
                        </div>
                        <div id="ActionMessageBox2" class="comment_content action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                        <div class="post_submit">
                            <input type="hidden" id="EmailTargetId" name="TargetId" value="<%=TheTopic.TopicId %>" />
                            <input type="hidden" id="EmailBelongType" name="BelongType" value="<%=CommentBelongTypes.Topic %>" />
                            <input type="submit" id="SubmitEmail" name="SubmitEmail" class="submit" value="<%=LangRes.Get("SendEmail") %>" onclick="SubmitPostEmailForm('PostEmailForm', 'SubmitEmail'); return false;" />
                        </div>
                    </form>
                    </div>
                </div>
                <% } %>

            </div>
            <% } %>
        </div>

        <% if(BlockSetting.IsSetTopicDetailPageBlock || (TheTopic.Channel != null && TopicList.Count > 1)){ %>
        <div id="side">
            <% if (TheTopic.Channel != null){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l">&nbsp;</div>
                    <div class="bar_wrap"><h4><%=TheTopic.Channel.Name %></h4></div>
                    <div class="bar_r">&nbsp;</div>
                </div>

                <div class="panel_box">
                    <div class="panel_box_inner">
                        <ul class="channel_topic_list">
                        <% foreach (Topic topic in TopicList) { %>
                            <li>
                                <a href="<%=URL("TopicDetailPage", topic.UrlName) %>" title="<%=topic.Title %>" class="<%=Helper.IF(topic.TopicId == TheTopic.TopicId, "current") %>"><%=topic.Title %></a>
                            </li>
                        <% } %>
                        </ul>
                    </div>
                </div>
            </div>
            <% } %>


            <% if (BlockSetting.IsSetTopicDetailPageBlock){ %>
            <div class="panel">
                <div class="bar">
                    <div class="bar_l active_bar_l">&nbsp;</div>
                    <div class="bar_wrap">
                        <a href="javascript:void(0);" class="title active_title"><%=BlockSetting.TopicDetailPageBlockTitle %></a>
                    </div>
                    <div class="bar_r">&nbsp;</div>
                </div>
                <div class="panel_box">
                    <div class="panel_box_inner custom_block">
                        <%=BlockSetting.TopicDetailPageBlockContent %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>

        <div class="clear"></div>
    </div>

    <script type="text/javascript">
        $(function () {
            <% if (DisplaySetting.OpenTopicComment == FunctionOpenTypes.ForceOpen || TheTopic.EnableComment || SiteSetting.OpenEmailContact) { %>
            InitMenus("#post_comment_panel .bar .comment_menu", "#post_comment_panel .comment_panel_item", "active_title");
            <% if(ActionResult.Result != PageActionResultType.Default){ %>
            alert('<%=ActionResult.Message %>');
            <% } %>
            <% } %>
        });
    </script>

<!-- #include file="includes/_foot.html" -->

</body>
</html>
