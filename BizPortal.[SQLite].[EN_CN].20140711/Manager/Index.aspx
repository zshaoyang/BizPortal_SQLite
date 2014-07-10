<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.IndexPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="includes/_meta.html" -->
    <link href="<%=AdminRoot %>css/index.css?v=20140109" type="text/css" rel="Stylesheet" />
</head>
<body id="body">
    <div class="stage">

<!-- #include file="includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageHomePage") %></strong>
                </div>

                <div class="main_content">
                    <% if(CommentList.Count > 0){ %>
                    <table class="list_table comment_list info_table" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr><th colspan="8" id="comment_table_title" valign="middle"><%=LangRes.Text("NewUnValidatedComments") %></th></tr>
                            <tr>
                                <th style="width:50px;vertical-align:middle;">ID</th>
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
                            foreach(Comment comment in CommentList)
                            {
                        %>
                            <tr id="commentItem_<%=comment.CommentId %>">
                                <td><%=comment.CommentId %></td>
                                <td><%=LangRes.Text(comment.BelongType + "Comment") %></td>
                                <td><%=comment.AuthorName %>(<%=comment.AuthorEmail %>)</td>
                                <td><span class="red" id="CommentBrief_<%=comment.CommentId %>">【<%=LangRes.Text("NotApproved") %>】</span><%=Helper.CUT(StringHelper.RemoveHTML(comment.Content), 100) %></td>
                                <td><%=Helper.IF(comment.ReplyTime.Date != DateTime.MinValue.Date, Helper.CUT(StringHelper.RemoveHTML(comment.ReplyContent), 100), "-") %></td>
                                <td><%=Helper.DATETIME(comment.CreateTime) %></td>
                                <td><%=Helper.IF(comment.ReplyTime.Date != DateTime.MinValue.Date, Helper.DATETIME(comment.ReplyTime), "-") %></td>
                                <td>
                                    <a id="btnValidateComment_<%=comment.CommentId %>" class="btn_validate_comment" href="<%=API_URL("AdminCommentHandler") %>?action=101&CommentId=<%=comment.CommentId %>&Validated=True">[<%=LangRes.Text("ValidateApproved") %>]</a>
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
                                    <a href="<%=ADMIN_URL("CommentManagerPage") %>"><%=LangRes.Text("ViewAll") %>&gt;&gt;</a>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    <% } %>

                    <table class="editor_table info_table" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr><th colspan="4" id="stat_title" valign="middle"><%=LangRes.Text("SiteStat") %></th></tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label><%=LangRes.Text("ProductCount") %>:</label></th>
                                <td class="field" style="width:35%;"><div class="info" id="StatTotalProduct">-</div></td>

                                <th class="title" style="width:15%;"><label><%=LangRes.Text("ArticleCount") %>:</label></th>
                                <td class="field" style="width:35%;"><div class="info" id="StatTotalArticle">-</div></td>
                            </tr>

                            <tr>
                                <th class="title" style=""><label><%=LangRes.Text("CommentCount") %>:</label></th>
                                <td class="field" style=""><div class="info" id="StatTotalComment">-</div></td>

                                <th class="title" style=""><label><%=LangRes.Text("AttachCount") %>:</label></th>
                                <td class="field" style=""><div class="info" id="StatTotalAttach">-</div></td>
                            </tr>
                        </tbody>
                    </table>

                    <table class="editor_table info_table" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr><th colspan="4" id="sysinfo_title" valign="middle"><%=LangRes.Text("AppSystemInfo") %></th></tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label><%=LangRes.Text("AppVersion") %>:</label></th>
                                <td class="field" style="width:35%;"><div class="info"><%=AppInfo.AppName %>&nbsp;V<%=AppInfo.Version %>&nbsp;<%=AppInfo.Edition %>&nbsp;(<%=AppInfo.Build %>)</div></td>

                                <th class="title" style="width:15%;"><label><%=LangRes.Text("OS") %>:</label></th>
                                <td class="field" style="width:35%;"><div class="info"><%=OSVersion %></div></td>
                            </tr>

                            <tr>
                                <th class="title" style=""><label><%=LangRes.Text("IISVersion") %>:</label></th>
                                <td class="field" style=""><div class="info"><%=IISVersion %></div></td>

                                <th class="title" style=""><label><%=LangRes.Text("DotNetVersion") %>:</label></th>
                                <td class="field" style=""><div class="info"><%=NETVersion %></div></td>
                            </tr>
                            
                            <tr>
                                <th class="title" style=""><label><%=LangRes.Text("AppMemoryUsed") %>:</label></th>
                                <td class="field" style=""><div class="info"><%=LangRes.Text("PhysicalMemory") %>:<%=MemoryInfo.dwTotalPhys/(1024*1024)%>M  / <%=LangRes.Text("CurrentAppMemoryUsed") %>:<%=MemoryInfo.dwCurrentMemorySize/1024%>M</div></td>

                                <th class="title" style=""><label><%=LangRes.Text("DatabaseSize") %>:</label></th>
                                <td class="field" style=""><div class="info"><%=LangRes.Text("Database") %>:<%=Helper.SIZE(DbInfo.DataSize) %> / <%=LangRes.Text("Log") %>:<%=Helper.SIZE(DbInfo.LogSize)%></div></td>
                            </tr>
                            
                            <tr>
                                <th class="title" style=""><label><%=LangRes.Text("DatabaseVersion") %>:</label></th>
                                <td class="field" style="" colspan="3"><div class="info"><%=DbInfo.Version %></div></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

<!-- #include file="includes/_footer.html" -->

    </div>

    <script type="text/javascript">
        $(function () {
            $.get("<%=API_URL("AdminConfigHandler") %>?action=1&__AJAX=True", null, function (result) {
                var jsonData = eval(result);
                var info = jsonData["Data"];

                for (var key in info) {
                    var statDiv = $("#Stat" + key);
                    if (statDiv[0]) {
                        statDiv.html(info[key]);
                    }
                }
            });


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
        });
    </script>
</body>
</html>
