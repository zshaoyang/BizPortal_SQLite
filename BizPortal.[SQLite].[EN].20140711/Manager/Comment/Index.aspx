<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.CommentPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=WebRoot %>Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/comment-min.js?v=20131225"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageCommentData") %></strong>
                </div>
                <div class="main_content">
                    <div class="search_panel">
                        <form id="SearchForm" name="SearchForm" action="<%=ADMIN_URL("CommentManagerPage") %>" method="post">
                            <div id="basic_search_condition_container">
                                <table class="search_table" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <th style=""><label for="SearchKeywords"><%=LangRes.Text("SearchKeywords") %></label></th>
                                        <td style="width:25%;"><input type="text" id="SearchKeywords" name="Keywords" value="<%=SearchFilter.Keywords %>" class="txt" /></td>
                                        <th style=""><label for="SearchAuthor"><%=LangRes.Text("AuthorName") %></label></th>
                                        <td style="width:25%;"><input type="text" id="SearchAuthor" name="Author" value="<%=SearchFilter.Author %>" class="txt" /></td>
                                        <th style=""><label for="SearchValidated"><%=LangRes.Text("ValidatedStatus") %></label></th>
                                        <td style="width:25%;">
                                            <select id="SearchValidated" name="Validated" class="select">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                                <option value="True" <%=Helper.SELECTED("Validated", true, SearchFilter.Validated) %>><%=LangRes.Text("Approved") %></option>
                                                <option value="False" <%=Helper.SELECTED("Validated", false, SearchFilter.Validated) %>><%=LangRes.Text("NotApproved") %></option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style=""><label for="SearchBelongType"><%=LangRes.Text("BelongType") %></label></th>
                                        <td style="width:25%;">
                                            <select id="SearchBelongType" name="BelongType" class="select">
                                                <option value="null"><%=LangRes.Text("Unlimited") %></option>
                                            <%  foreach (string name in Enum.GetNames(typeof(CommentBelongTypes))) {  %>
                                                <option value="<%=name %>" <%=Helper.SELECTED("BelongType", name, SearchFilter.BelongType) %>><%=LangRes.Text(name + "Comment") %></option>
                                            <%  }  %>
                                            </select>
                                        </td>
                                        <th style=""><label for="SearchStartCreateTime"><%=LangRes.Text("CreateTime") %></label></th>
                                        <td colspan="3">
                                            <input type="text" id="SearchStartCreateTime" name="StartCreateTime" value="<%=Helper.OUT_DATETIME(SearchFilter.StartCreateTime) %>" class="txt dt_txt" onclick="WdatePicker();" />
                                            ~
                                            <input type="text" id="SearchEndCreateTime" name="EndCreateTime" value="<%=Helper.OUT_DATETIME(SearchFilter.EndCreateTime) %>" class="txt dt_txt" onclick="WdatePicker();" />
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
                    <form id="ManageForm" action="<%=API_URL("AdminCommentHandler") %>?action=103" method="post" enctype="application/x-www-form-urlencoded">
                    <table class="list_table comment_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th style="width:50px;vertical-align:middle;"><input type="checkbox" id="CheckAll" onclick="CheckAllItems('CheckAll', 'CommentIds', 'CheckAll2');" />&nbsp;<label for="CheckAll">ID</label></th>
                                <th><%=LangRes.Text("BelongType") %></th>
                                <th><%=LangRes.Text("AuthorName") %></th>
                                <th><%=LangRes.Text("Content") %></th>
                                <th><%=LangRes.Text("ReplyContent") %></th>
                                <th><%=LangRes.Text("CreateTime") %></th>
                                <th><%=LangRes.Text("ReplyTime") %></th>
                                <th style="width:150px;">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach(Comment comment in CommentPageList)
                            {
                        %>
                            <tr id="commentItem_<%=comment.CommentId %>">
                                <td><input type="checkbox" id="CommentIds_<%=comment.CommentId %>" name="CommentIds" value="<%=comment.CommentId %>" />&nbsp;<label for="CommentIds_<%=comment.CommentId %>"><%=comment.CommentId %></label></td>
                                <td><%=LangRes.Text(comment.BelongType + "Comment") %></td>
                                <td><%=Helper.HIGHLIGHT(comment.AuthorName, SearchFilter.Author) %>(<%=Helper.HIGHLIGHT(comment.AuthorEmail, SearchFilter.Author) %>)</td>
                                <td><span id="CommentBrief_<%=comment.CommentId %>" class="<%=Helper.IF(comment.Validated, "green", "red") %>">【<%=Helper.IF(comment.Validated, LangRes.Text("Approved"), LangRes.Text("NotApproved")) %>】</span><%=Helper.HIGHLIGHT(Helper.CUT(StringHelper.RemoveHTML(comment.Content), 100), SearchFilter.Keywords) %></td>
                                <td><%=Helper.IF(comment.ReplyTime.Date != DateTime.MinValue.Date, Helper.HIGHLIGHT(Helper.CUT(StringHelper.RemoveHTML(comment.ReplyContent), 100), SearchFilter.Keywords), "-") %></td>
                                <td><%=Helper.DATETIME(comment.CreateTime) %></td>
                                <td><%=Helper.IF(comment.ReplyTime.Date != DateTime.MinValue.Date, Helper.DATETIME(comment.ReplyTime), "-") %></td>
                                <td>
                                <% if(comment.Validated){ %>
                                    <a id="btnValidateComment_<%=comment.CommentId %>" class="btn_validate_comment" href="<%=API_URL("AdminCommentHandler") %>?action=101&CommentId=<%=comment.CommentId %>&Validated=False">[<%=LangRes.Text("ValidateRejected") %>]</a>
                                <% } else { %>
                                    <a id="btnValidateComment_<%=comment.CommentId %>" class="btn_validate_comment" href="<%=API_URL("AdminCommentHandler") %>?action=101&CommentId=<%=comment.CommentId %>&Validated=True">[<%=LangRes.Text("ValidateApproved") %>]</a>
                                <% } %>
                                    &nbsp;
                                    <a id="btnReplyComment_<%=comment.CommentId %>" class="btn_reply_comment" href="<%=ADMIN_URL("CommentViewPage", comment.CommentId) %>">[<%=LangRes.Text("Reply") %>]</a>
                                    &nbsp;
                                    <a id="btnDeleteComment_<%=comment.CommentId %>" class="btn_delete_comment" href="<%=API_URL("AdminCommentHandler") %>?action=102&CommentId=<%=comment.CommentId %>">[<%=LangRes.Text("Delete") %>]</a>
                                </td>
                            </tr>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="8">
                                    <div class="tool_panel fl">
                                        <input type="checkbox" id="CheckAll2" onclick="CheckAllItems('CheckAll2', 'CommentIds', 'CheckAll');" />&nbsp;<input id="SubmitDeleteChecked" type="submit" value="<%=LangRes.Text("DeleteSelected") %>" class="btn" onclick="return DeleteComments('ManageForm', '<%=LangRes.Text("ConfirmToDeleteSelectedCommentData") %>');" />
                                    </div>
                                    <div class="fl">
<% CurrentPager = CommentPager; %>
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
        $("td .btn_delete_comment").each(function () {
            var btn = $(this);
            var btnId = btn.attr("id");
            
            btn.bind("click", function () {

                QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheComment") %>", function (jsonData) {
                    var actionResult = parseInt(jsonData["Result"]);
                    var commentId = jsonData["Data"];
                    var commentItem = $("#commentItem_" + commentId);

                    commentItem.fadeOut(400);
                    setTimeout(function () {
                        commentItem.remove();
                    }, 500);
                    
                    return true;
                });
                return false;
            });
        });

        $("td .btn_validate_comment").each(function () {
            var btn = $(this);
            var btnId = btn.attr("id");
            var href = btn.attr("href");
            var isValidated = href.indexOf("Validated=False") >= 0;

            btn.bind("click", function () {
                btn = $(this);

                QueryLinkAction(btnId, isValidated ? "<%=LangRes.Text("ConfirmToValidateRejectedTheComment") %>" : "<%=LangRes.Text("ConfirmToValidateApprovedTheComment") %>", function (jsonData) {
                    var actionResult = parseInt(jsonData["Result"]);
                    var comment = jsonData["Data"];
                    var commentId = comment["CommentId"];
                    var commentValidated = comment["Validated"];
                    var commentItem = $("#btnValidateComment_" + commentId);

                    commentItem.html(commentValidated ? "[<%=LangRes.Text("ValidateRejected") %>]" : "[<%=LangRes.Text("ValidateApproved") %>]");

                    var briefItem = $("#CommentBrief_" + commentId);
                    var briefItemContent = briefItem.html();
                    if (commentValidated) {
                        briefItem.html(briefItemContent.replace("<%=LangRes.Text("NotApproved") %>", "<%=LangRes.Text("Approved") %>"));
                        briefItem.removeClass("red");
                        briefItem.addClass("green");
                        btn.attr("href", href.replace("Validated=True", "Validated=False"));
                    }
                    else {
                        briefItem.html(briefItemContent.replace("<%=LangRes.Text("Approved") %>", "<%=LangRes.Text("NotApproved") %>"));
                        briefItem.removeClass("green");
                        briefItem.addClass("red");
                        btn.attr("href", href.replace("Validated=False", "Validated=True"));
                    }

                    return true;
                });
                return false;
            });
        });
    </script>
</body>
</html>
