<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.UI.ArticleDetailPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->

    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/article.css?v=<%=AppInfo.Build %>" />
    <link type="text/css" rel="Stylesheet" href="<%=SkinRoot %>css/comment.css?v=<%=AppInfo.Build %>" />
</head>
<body id="body">

<!-- #include file="includes/_head.html" -->

    <div id="main" class="wrap">
        <div id="position">
            <a href="<%=URL("HomePage") %>"><%=LangRes.Get("HomePage") %></a>
            <em>&nbsp;</em>
            <a href="<%=URL("ArticleListPage") %>"><%=LangRes.Get("NewsOrActivityList") %></a>
            <em>&nbsp;</em>
            <% if (TheArticle.Category != null) { %>
            <em>&nbsp;</em>
            <a href="<%=URL("ArticleCategoryPage", TheArticle.Category.UrlName) %>"><%=TheArticle.Category.Name %></a>
            <% } %>
            <% if (TheArticle.Level2Category != null) { %>
            <em>&nbsp;</em>
            <a href="<%=URL("ArticleCategoryPage", TheArticle.Level2Category.UrlName) %>"><%=TheArticle.Level2Category.Name %></a>
            <% } %>
            <em>&nbsp;</em>
            <span><%=LangRes.Get("ReadNews") %></span>
        </div>

        <div id="content">
            <h2><%=TheArticle.Title %></h2>

            <div class="panel">
                <div class="box">
                    <div class="box_inner">
                        <div id="text_content"><%=TheArticle.Content %></div>
                        <div class="clear"></div>

                        <ul id="other_articles">
                        <% if(TheArticle.PrevArticle != null){ %>
                            <li id="prev"><a href="<%=URL("ArticleDetailPage", TheArticle.PrevArticle.ArticleId) %>" title="<%=TheArticle.PrevArticle.Title %>"><%=LangRes.Get("PreviousNews") %>:<%=TheArticle.PrevArticle.Title %></a></li>
                        <% } %>
                        <% if(TheArticle.NextArticle != null){ %>
                            <li id="next"><a href="<%=URL("ArticleDetailPage", TheArticle.NextArticle.ArticleId) %>" title="<%=TheArticle.NextArticle.Title %>"><%=LangRes.Get("NextNews") %>：<%=TheArticle.NextArticle.Title %></a></li>
                        <% } %>
                        </ul>

                        <div class="clear"></div>
                    </div>
                </div>
            </div>

            <% if(BlockSetting.IsSetArticleDetailPageBlock){ %>
            <div class="divide"></div>
            <div class="panel">
                <div class="bar">
                    <h4 class="title"><%=BlockSetting.ArticleDetailPageBlockTitle %></h4>
                </div>
                <div class="box">
                    <div class="box_inner custom_block">
                        <%=BlockSetting.ArticleDetailPageBlockContent %>
                    </div>
                </div>
            </div>
            <% } %>

            <% if (DisplaySetting.OpenArticleComment == FunctionOpenTypes.ForceOpen || TheArticle.EnableComment || SiteSetting.OpenEmailContact){ %>
            <div class="panel comment_box">
                <div class="bar">
                    <% if (DisplaySetting.OpenArticleComment == FunctionOpenTypes.ForceOpen || TheArticle.EnableComment){ %>
                    <a class="title active" href="javascript:void(0);" onclick="return false;" data="comment_list_box"><%=LangRes.Get("MessageCommentList") %></a>
                    <a class="title" href="javascript:void(0);" onclick="return false;" data="post_comment_box"><%=LangRes.Get("PostComment") %></a>
                    <% } %>
                <% if(SiteSetting.OpenEmailContact){ %>
                    <a class="title" href="javascript:void(0);" onclick="return false;" data="post_email_box"><%=LangRes.Get("EmailContact") %></a>
                <% } %>
                </div>

                <% if (DisplaySetting.OpenArticleComment == FunctionOpenTypes.ForceOpen || TheArticle.EnableComment) { %>
                <div id="comment_list_box" class="box comment_panel_item">
                    <div class="box_inner">
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

                <div id="post_comment_box" class="box comment_panel_item post_comment_panel none">
                    <div class="box_inner">
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
                                <input type="hidden" id="BelongType" name="BelongType" value="<%=CommentBelongTypes.Article %>" />
                                <input type="hidden" id="TargetId" name="TargetId" value="<%=TheArticle.ArticleId %>" />
                                <input type="submit" id="SubmitComment" name="SubmitComment" class="submit" value="<%=LangRes.Get("SubmitCommentMessage") %>" onclick="SubmitPostCommentForm('PostCommentForm', 'SubmitComment'); return false;" />
                            </div>
                        </form>
                    </div>
                </div>
                <% } %>

                <% if(SiteSetting.OpenEmailContact){ %>
                <div id="post_email_box" class="box  comment_panel_item post_comment_panel none">
                    <div class="box_inner">
                        <form id="PostEmailForm" action="<%=API_URL("OperationHandler") %>?action=200" method="post" enctype="application/x-www-form-urlencoded">
                            <div class="post_title">
                                <label for="txtEmailTitle"><%=LangRes.Get("EmailTitle") %>:</label>
                                <input type="text" id="txtEmailTitle" name="EmailTitle" class="txt" />
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
                                <input type="hidden" id="EmailTargetId" name="TargetId" value="<%=TheArticle.ArticleId %>" />
                                <input type="hidden" id="EmailBelongType" name="BelongType" value="<%=CommentBelongTypes.Article %>" />
                                <input type="submit" id="SubmitEmail" name="SubmitEmail" class="submit" value="<%=LangRes.Get("SendEmail") %>" onclick="SubmitPostEmailForm('PostEmailForm', 'SubmitEmail'); return false;" />
                            </div>
                        </form>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
        </div>

        <div class="clear"></div>
    </div>

    <div class="clear"></div>

    <script type="text/javascript">
        $(function () {
            <% if (DisplaySetting.OpenArticleComment == FunctionOpenTypes.ForceOpen || TheArticle.EnableComment || SiteSetting.OpenEmailContact) { %>
            InitMenus('.panel .bar a.title', '.panel .box.comment_panel_item', 'active');
            <% if(ActionResult.Result != PageActionResultType.Default){ %>
            alert('<%=ActionResult.Message %>');
            <% } %>
            <% } %>
        });
    </script>

<!-- #include file="includes/_foot.html" -->

</body>
</html>
