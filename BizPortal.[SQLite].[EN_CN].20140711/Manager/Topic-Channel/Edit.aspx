﻿<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.EditChannelPage" %>

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
                    <strong><%=LangRes.Text("UpdateTopicChannelData") %></strong>
                    <span><a href="<%=ADMIN_URL("TopicChannelManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("AddTopicChannelPage") %>" class="more_link"><%=LangRes.Text("AddTopicChannelData") %>+</a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminChannelHandler") %>?action=101" method="post" enctype="multipart/form-data">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label for="txtChannelName"><%=LangRes.Text("ChannelName") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtChannelName" name="Name" class="txt" maxlength="100" value="<%=TheChannel.Name %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtChannelSortOrder"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtChannelSortOrder" name="SortOrder" class="txt" maxlength="3" value="<%=TheChannel.SortOrder %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtChannelKeywords"><%=LangRes.Text("SEOKeywords") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtChannelKeywords" name="Keywords" class="txt" maxlength="200" value="<%=TheChannel.Keywords %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtChannelDescription"><%=LangRes.Text("SEODescription") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtChannelDescription" name="Description" class="txt" maxlength="200" value="<%=TheChannel.Description %>" /></td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="hidden" id="ChannelId" name="ChannelId" value="<%=TheChannel.ChannelId %>" />
                                    <input type="submit" value="<%=LangRes.Text("UpdateTopicChannelData") %>" class="submit" />
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
</body>
</html>
