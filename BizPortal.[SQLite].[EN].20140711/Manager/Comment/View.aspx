<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.CommentViewPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/article-min.js?v=20131226"></script>

<!-- #include file="../includes/_editor.html" -->
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ViewComment") %></strong>
                    <span><a href="<%=ADMIN_URL("CommentManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminCommentHandler") %>?action=100" method="post" enctype="multipart/form-data">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label><%=LangRes.Text("AuthorName") %>:</label></th>
                                <td class="field" style="width:35%;"><%=CommentDetail.AuthorName %></td>

                                <th class="title" style="width:15%;"><label><%=LangRes.Text("EmailAddress") %>:</label></th>
                                <td class="field" style="width:35%;"><%=CommentDetail.AuthorEmail %></td>
                            </tr>

                            <tr>
                                <th class="title"><label><%=LangRes.Text("BelongTo") %>:</label></th>
                                <td class="field">
                                <% 
                                switch (CommentDetail.BelongType)
                                {    
                                    case CommentBelongTypes.Topic:
                                %>
                                    <% if(CommentDetail.BelongTopic != null){ %><a href="<%=URL("TopicDetailPage", CommentDetail.BelongTopic.UrlName) %>" target="_blank"><%=CommentDetail.BelongTopic.Title %></a><% } else { %>-<% } %>
                                <% 
                                        break;
                                    case CommentBelongTypes.Article:
                                %>
                                    <% if(CommentDetail.BelongArticle != null){ %><a href="<%=URL("ArticleDetailPage", CommentDetail.BelongArticle.ArticleId) %>" target="_blank"><%=CommentDetail.BelongArticle.Title %></a><% } else { %>-<% } %>
                                <% 
                                        break;
                                    case CommentBelongTypes.Product:
                                %>
                                    <% if(CommentDetail.BelongProduct != null){ %><a href="<%=URL("ProductDetailPage", CommentDetail.BelongProduct.ProductId) %>" target="_blank"><%=CommentDetail.BelongProduct.Name %></a><% } else { %>-<% } %>
                                <% 
                                        break;
                                    default:
                                %>
                                    <a href="<%=URL("MessageBoardPage") %>" target="_blank"><%=LangRes.Text("MessageBoard") %></a>
                                <% 
                                        break;
                                }
                                %>
                                </td>

                                <th class="title"><label for="selectValidated"><%=LangRes.Text("ValidatedStatus") %>:</label></th>
                                <td class="field">
                                    <select id="selectValidated" name="Validated" class="select">
                                        <option value="True" <%=Helper.SELECTED("Validated", true, CommentDetail.Validated) %>><%=LangRes.Text("Approved") %></option>
                                        <option value="False" <%=Helper.SELECTED("Validated", false, CommentDetail.Validated) %>><%=LangRes.Text("NotApproved") %></option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label><%=LangRes.Text("CreateTime") %>:</label></th>
                                <td class="field"><%=Helper.DATETIME(CommentDetail.CreateTime) %></td>

                                <th class="title"><label><%=LangRes.Text("ReplyTime") %>:</label></th>
                                <td class="field"><%=Helper.IF(CommentDetail.ReplyTime.Date == DateTime.MinValue.Date, "-", Helper.DATETIME(CommentDetail.ReplyTime)) %></td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtReplyContent"><%=LangRes.Text("Content") %>:</label></th>
                                <td class="field" colspan="3">
                                    <%=CommentDetail.Content %>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtReplyContent"><%=LangRes.Text("ReplyContent") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtReplyContent" name="ReplyContent" rows="5" cols="60" class="txt"><%=DEnCodeHelper.HtmlEncode(CommentDetail.ReplyContent) %></textarea>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="hidden" id="CommentId" name="CommentId" value="<%=CommentDetail.CommentId %>" />
                                    <input type="submit" value="<%=LangRes.Text("SubmitReply") %>" class="submit" />
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
            InitEditor('txtReplyContent');   
        });
    </script>
</body>
</html>
