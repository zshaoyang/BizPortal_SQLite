<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AddLanternSlidePage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../../includes/_meta.html" -->
    <link href="<%=WebRoot %>Scripts/jquery.uploadify/uploadify.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery.uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("AddLanternSlideData") %></strong>
                    <span><a href="<%=ADMIN_URL("SliderManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("DisplayConfigPage") %>" class="more_link"><%=LangRes.Text("DisplaySetting") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=210" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:15%;"><label for="txtName"><%=LangRes.Text("Name") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtName" name="Name" class="txt" maxlength="100" /></td>

                                <th class="title" style="width:15%;"><label for="txtTitle"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtTitle" name="Title" class="txt" maxlength="100" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtLink"><%=LangRes.Text("Link") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtLink" name="Link" class="txt" maxlength="100" /></td>

                                <th class="title" style="width:15%;"><label for="txtSortOrder"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSortOrder" name="SortOrder" class="txt" maxlength="100" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtImageFile"><%=LangRes.Text("Image") %>:</label></th>
                                <td class="field" colspan="3">
                                    <% if(TempImageFile != null){ %>
                                    <div id="SliderImagePanel" class="product_img">
                                        <a id="SliderImageLink" href="<%=TempImageFile.WebPath %>" target="_blank"><img id="SliderImage" src="<%=TempImageFile.WebPath %>" alt="<%=TempImageFile.WebPath %>" /></a>
                                    </div>
                                    <% } else { %>
                                    <div id="SliderImagePanel" class="product_img none">
                                        <a id="SliderImageLink" href="" target="_blank"><img id="SliderImage" src="" alt="" /></a>
                                    </div>
                                    <% } %>
                                    <div><input type="file" id="txtImageFile" name="ImageFile" class="txt" /></div>
                                    <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<%=CurrentSkin.SliderSize %></div>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("AddLanternSlideData") %>" class="submit" />
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    </form>
                </div>
            </div>
        </div>

<!-- #include file="../../includes/_footer.html" -->

    </div>
    <script type="text/javascript">
        $(function(){
            var TextTips = new FormTextTip({
                "txtName": "<%=LangRes.Text("NameForShow") %>",
                "txtTitle": "<%=LangRes.Text("TitleForMouseHover") %>",
                "txtLink": "<%=LangRes.Text("ClickToRedirectLink") %>",
                "txtSortOrder": "<%=LangRes.Text("ValueMoreLessPriorityHigher") %>"
            }, "txt_tip");

            <%if(ActionResult.Data != null){%>
            var TempCategoryJson = <%=ActionResult.Data %>;
            for(var prpName in TempCategoryJson){
                var prpValue = TempCategoryJson[prpName];
                if(prpValue != null && prpValue != ""){
                    $("input[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                    $("textarea[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                }
            }
            <%}%>



            $("#txtImageFile").uploadify({
                'swf'           : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'      : '<%=API_URL("AdminAttachHandler") %>?action=102&__AJAX=True',
                'multi'         : false,
                'method'        : 'post',
                'fileObjName'   : 'ImageFile',
                'formData'      : {"SliderId" : 0, "__AdminAuth" : ADMIN_AUTH},
                'queueSizeLimit': 1,
                'fileSizeLimit' : '2MB',
                'buttonText'    : '<%=LangRes.Text("SelectImageFiles") %>',
                'fileTypeExts'  : '*.gif; *.jpg; *.png', 
                'onUploadSuccess': function(file, data, response) {
                    var jsonData = $.parseJSON(data);
                    var imgPath = jsonData["Data"];
                    $("#SliderImagePanel").show();
                    $("#SliderImageLink").attr("href", WEB_ROOT + imgPath);
                    $("#SliderImage").attr("src", WEB_ROOT + imgPath);
                },
                'width'         : 120,
                'height'        : 30
            }); 
        });
    </script>
</body>
</html>
