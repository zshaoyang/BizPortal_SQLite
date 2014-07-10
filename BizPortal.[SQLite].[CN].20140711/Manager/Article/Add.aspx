<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AddArticlePage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <link href="<%=WebRoot %>Scripts/jquery.uploadify/uploadify.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery.uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/article-min.js?v=20131226"></script>

<!-- #include file="../includes/_editor.html" -->
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("AddArticleData") %></strong>
                    <span><a href="<%=ADMIN_URL("ArticleManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminArticleHandler") %>?action=100" method="post" enctype="multipart/form-data">
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
                                <th class="title" style="width:15%;"><label for="txtArticleTitle"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtArticleTitle" name="Title" class="txt" maxlength="100" /></td>

                                <th class="title" style="width:15%;"><label for="selectArticleEnableComment"><%=LangRes.Text("EnableComment") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectArticleEnableComment" name="EnableComment" class="select">
                                        <option value="False"><%=LangRes.Text("No") %></option>
                                        <option value="True"><%=LangRes.Text("Yes") %></option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectArticleCategoryId"><%=LangRes.Text("ArticleCategory") %>:</label></th>
                                <td class="field" colspan="3">
                                    <select id="selectArticleCategoryId" name="CategoryId" class="select" onchange="LoadChildCategoryList('<%=API_URL("AdminCategoryHandler") %>?action=600&CategoryId=' + $(this).val(),'selectArticleLevel2CategoryId', {'0': '<%=LangRes.Text("SelectBelongLevel2Category") %>'});">
                                        <option value="0"><%=LangRes.Text("SelectBelongCategory") %></option>
                                    <% foreach(ArticleCategory category in RootArticleCategoryList){ %>
                                        <option value="<%=category.CategoryId %>"><%=category.Name %>(<%=category.UrlName %>)</option>
                                    <% } %>
                                    </select>
                                    <select id="selectArticleLevel2CategoryId" name="Level2CategoryId" class="select">
                                        <option value="0"><%=LangRes.Text("SelectBelongLevel2Category") %></option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtArticleContent"><%=LangRes.Text("Text") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtArticleContent" name="Content" rows="20" cols="60" class="txt"></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><%=LangRes.Text("Attach") %>:</th>
                                <td class="field" colspan="3">
                                    <ul id="ArticleAttachList" class="attach_list">
                                    <% foreach(AttachFile attach in TempAttachList){ %>
                                        <li id="AttachListItem_<%=attach.AttachId %>">
                                            <div id="AttachItemPanel_<%=attach.AttachId %>">
                                                <a id="linkAttachName_<%=attach.AttachId %>" href="javascript:void(0);" target="_blank" onclick="return ShowAttachRenamePanel(<%=attach.AttachId %>);" class="name"><%=attach.FullName %></a>
                                                &nbsp;
                                                <a href="<%=attach.WebPath %>" target="_blank" class="tool_btn"><%=LangRes.Text("View") %></a>
                                                &nbsp;
                                                <a href="javascript:void(0);" class="tool_btn" onclick="return InsertAttachToEditor('txtArticleContent', '<%=attach.WebPath %>', '<%=attach.Name %>');"><%=LangRes.Text("Insert") %></a>
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
                                                <a href="javascript:void(0);" class="tool_btn" onclick="return InsertAttachToEditor('txtArticleContent', '${WebPath}', '${Name}');"><%=LangRes.Text("Insert") %></a>
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
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="submit" value="<%=LangRes.Text("AddArticleData") %>" class="submit" />
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

            InitEditor('txtArticleContent');

            BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");

            $("#AttachFile").uploadify({
                'swf'           : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'      : '<%=API_URL("AdminAttachHandler") %>?action=110&__AJAX=True',
                'multi'         : true,
                'method'        : 'post',
                'fileObjName'   : 'AttachFile',
                'formData'      : {"TargetId" : 0, "BelongType" : "<%=AttachBelongTypes.Article %>", "__AdminAuth" : ADMIN_AUTH},
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
                    ParseTemplate('AttachItemTemplate', 'ArticleAttachList', {"AttachId" : attachId, "WebPath" : attachWebPath, "FileExt" : attachExt, "Name" : attachName, "FullName" : attachFullName});

                    BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");
                },
                'width'         : 120,
                'height'        : 30
            });
        });
    </script>
</body>
</html>
