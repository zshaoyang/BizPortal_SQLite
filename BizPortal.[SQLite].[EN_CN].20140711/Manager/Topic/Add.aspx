<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AddTopicPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <link href="<%=WebRoot %>Scripts/jquery.uploadify/uploadify.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery.uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/topic-min.js?v=20131226"></script>

<!-- #include file="../includes/_editor.html" -->
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("AddTopicData") %></strong>
                    <span><a href="<%=ADMIN_URL("TopicManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminTopicHandler") %>?action=100" method="post" enctype="multipart/form-data">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="PageActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label for="txtTopicTitle"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtTopicTitle" name="Title" class="txt" maxlength="100" /></td>

                                <th class="title" style="width:15%;"><label for="selectTopicChannelId"><%=LangRes.Text("TopicChannel") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectTopicChannelId" name="ChannelId" class="select">
                                        <option value="0"><%=LangRes.Text("SelectBelongTopicChannel") %></option>
                                    <% foreach(Channel channel in AllChannelList){ %>
                                        <option value="<%=channel.ChannelId %>"><%=channel.Name %></option>
                                    <% } %>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtTopicUrlName"><%=LangRes.Text("UrlName") %>:</label></th>
                                <td class="field">
                                    <input type="text" id="txtTopicUrlName" name="UrlName" class="txt" maxlength="30" />
                                </td>
                                <th class="title"><label for="txtTopicSortOrder"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field">
                                    <input type="text" id="txtTopicSortOrder" name="SortOrder" class="txt" maxlength="3" />
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtTopicKeywords"><%=LangRes.Text("SEOKeywords") %>:</label></th>
                                <td class="field">
                                    <input type="text" id="txtTopicKeywords" name="Keywords" class="txt" maxlength="200" />
                                </td>
                                <th class="title"><label for="txtTopicDescription"><%=LangRes.Text("SEODescription") %>:</label></th>
                                <td class="field">
                                    <input type="text" id="txtTopicDescription" name="Description" class="txt" maxlength="200" />
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtTopicContent"><%=LangRes.Text("Content") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtTopicContent" name="Content" rows="20" cols="60" class="txt"></textarea>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><%=LangRes.Text("Attach") %>:</th>
                                <td class="field" colspan="3">
                                    <ul id="TopicAttachList" class="attach_list">
                                    <% foreach(AttachFile attach in TempAttachList){ %>
                                        <li id="AttachListItem_<%=attach.AttachId %>">
                                            <div id="AttachItemPanel_<%=attach.AttachId %>">
                                                <a id="linkAttachName_<%=attach.AttachId %>" href="javascript:void(0);" target="_blank" onclick="return ShowAttachRenamePanel(<%=attach.AttachId %>);" class="name"><%=attach.FullName %></a>
                                                &nbsp;
                                                <a href="<%=attach.WebPath %>" target="_blank" class="tool_btn"><%=LangRes.Text("View") %></a>
                                                &nbsp;
                                                <a href="javascript:void(0);" class="tool_btn" onclick="return InsertAttachToEditor('txtTopicContent', '<%=attach.WebPath %>', '<%=attach.Name %>');"><%=LangRes.Text("Insert") %></a>
                                                &nbsp;
                                                <a id="btnDeleteAttach_<%=attach.AttachId %>" class="tool_btn delete_attach_btn" href="<%=API_URL("AdminAttachHandler") %>?action=112&AttachId=<%=attach.AttachId %>"><%=LangRes.Text("Delete") %></a>
                                            </div>
                                            <div id="AttachRenamePanel_<%=attach.AttachId %>" class="none"><input type="text" id="AttachName_<%=attach.AttachId %>" name="AttachName_<%=attach.AttachId %>" class="rename" onblur="RenameAttach(<%=attach.AttachId %>, '<%=API_URL("AdminAttachHandler") %>?action=111');" value="<%=attach.Name %>" /></div>
                                        </li>
                                    <% } %>
                                    </ul>

                                    <script type="text/html" id="AttachItemTemplate">
                                        <li id="AttachListItem_${AttachId}">
                                            <div id="AttachItemPanel_${AttachId}">
                                                <a id="linkAttachName_${AttachId}" href="javascript:void(0);" target="_blank" onclick="return ShowAttachRenamePanel(${AttachId});" class="name">${FullName}</a>
                                                &nbsp;
                                                <a href="${WebPath}" target="_blank" class="tool_btn"><%=LangRes.Text("View") %></a>
                                                &nbsp;
                                                <a href="javascript:void(0);" class="tool_btn" onclick="return InsertAttachToEditor('txtTopicContent', '${WebPath}', '${Name}');"><%=LangRes.Text("Insert") %></a>
                                                &nbsp;
                                                <a id="btnDeleteAttach_${AttachId}" class="tool_btn delete_attach_btn" href="<%=API_URL("AdminAttachHandler") %>?action=112&AttachId=${AttachId}"><%=LangRes.Text("Delete") %></a>
                                            </div>
                                            <div id="AttachRenamePanel_${AttachId}" class="none"><input type="text" id="AttachName_${AttachId}" name="AttachName_${AttachId}" class="rename" onblur="RenameAttach(${AttachId}, '<%=API_URL("AdminAttachHandler") %>?action=111');" value="${Name}" /></div>
                                        </li>
                                    </script>

                                    <div>
                                        <input type="file" id="AttachFile" name="AttachFile" class="txt" />
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtTopicAppendCode"><%=LangRes.Text("AppendCode") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtTopicAppendCode" name="AppendCode" rows="6" cols="60" class="txt"></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectTopicEnableComment"><%=LangRes.Text("EnableComment") %>:</label></th>
                                <td class="field">
                                    <select id="selectTopicEnableComment" name="EnableComment" class="select">
                                        <option value="False"><%=LangRes.Text("No") %></option>
                                        <option value="True"><%=LangRes.Text("Yes") %></option>
                                    </select>
                                </td>
                                <th class="title">&nbsp;</th>
                                <td class="field">
                                    &nbsp;
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
                                    <input type="submit" value="<%=LangRes.Text("AddTopicData") %>" class="submit" />
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
            var TextTips = new FormTextTip({
                "txtTopicUrlName": "<%=LangRes.Text("FriendlyURL") %>-http://<%=LangRes.Text("DomainName") %><%=URL("TopicDetailPage", "{" + LangRes.Text("UrlName") + "}") %>",
                "txtTopicSortOrder": "<%=LangRes.Text("ValueMoreLessPriorityHigher") %>",
                "txtTopicAppendCode": "<%=LangRes.Text("AppendCodeNote") %>"
            }, "txt_tip");

            <%if(ActionResult.Data != null){%>
            var TempChannelJson = <%=ActionResult.Data %>;
        
            for(var prpName in TempChannelJson){
                var prpValue = TempChannelJson[prpName];
                if(prpValue != null && prpValue != ""){
                    $("input[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                    $("textarea[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                }
            }
            <%}%>

            InitEditor('txtTopicContent');

            BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");

            $("#AttachFile").uploadify({
                'swf'           : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'      : '<%=API_URL("AdminAttachHandler") %>?action=110&__AJAX=True',
                'multi'         : true,
                'method'        : 'post',
                'fileObjName'   : 'AttachFile',
                'formData'      : {"TargetId" : 0, "BelongType" : "<%=AttachBelongTypes.Topic %>", "__AdminAuth" : ADMIN_AUTH},
                'queueSizeLimit': 5,
                'fileSizeLimit' : '2MB',
                'buttonText'    : '<%=LangRes.Text("SelectAttachFiles") %>',
                'onUploadSuccess': function(file, data, response) {
                    var jsonData = $.parseJSON(data);
                    var obj = jsonData["Data"];
                    var attachId = obj["AttachId"];
                    var attachPath = obj["Path"];
                    var attachName = obj["Name"];
                    var attachExt = obj["FileExt"];
                    var attachFullName = attachName == '' ? attachName : (attachName + '.' + attachExt);
                    var attachWebPath = WEB_ROOT + attachPath;
                    ParseTemplate('AttachItemTemplate', 'TopicAttachList', {"AttachId" : attachId, "WebPath" : attachWebPath, "FileExt" : attachExt, "Name" : attachName, "FullName" : attachFullName});

                    BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");
                },
                'width'         : 120,
                'height'        : 30
            });
        });
    </script>
</body>
</html>
