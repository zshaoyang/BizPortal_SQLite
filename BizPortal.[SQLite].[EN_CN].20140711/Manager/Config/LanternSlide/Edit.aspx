<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.EditLanternSlidePage" ValidateRequest="false" %>

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
                    <strong><%=LangRes.Text("UpdateLanternSlideData") %></strong>
                    <span><a href="<%=ADMIN_URL("SliderManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("AddSliderPage") %>" class="more_link"><%=LangRes.Text("AddLanternSlideData") %>+</a></span>
                    <span><a href="<%=ADMIN_URL("DisplayConfigPage") %>" class="more_link"><%=LangRes.Text("DisplaySetting") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=211" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <td class="field" style="width:35%;"><input type="text" id="txtName" name="Name" class="txt" maxlength="100" value="<%=TheLanternSlide.Name %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtTitle" name="Title" class="txt" maxlength="100" value="<%=TheLanternSlide.Title %>" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("Link") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtLink" name="Link" class="txt" maxlength="200" value="<%=TheLanternSlide.Link %>" /></td>

                                <th class="title" style="width:15%;"><label for="txtAccount"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtSortOrder" name="SortOrder" class="txt" maxlength="3" value="<%=TheLanternSlide.SortOrder %>" /></td>
                            </tr>
                            <tr>
                                <th class="title"><label for="txtImageFile"><%=LangRes.Text("Image") %>:</label></th>
                                <td class="field" colspan="3">
                                    <div id="SliderImagePanel" class="product_img<%=Helper.IF(string.IsNullOrEmpty(TheLanternSlide.Url), " none") %>">
                                        <a id="SliderImageLink" href="<%=TheLanternSlide.ImageWebPath %>" target="_blank"><img id="SliderImage" src="<%=TheLanternSlide.ImageWebPath %>" alt="<%=TheLanternSlide.ImageWebPath %>" /></a>
                                    </div>
                                    <div><input type="file" id="txtImageFile" name="ImageFile" class="txt" /></div>
                                    <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<%=CurrentSkin.SliderSize %></div>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="hidden" id="SlideId" name="SlideId" value="<%=TheLanternSlide.SlideId %>" />
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("UpdateLanternSlideData") %>" class="submit" />
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
            $("#txtImageFile").uploadify({
                'swf'              : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'         : '<%=API_URL("AdminAttachHandler") %>?action=102&__AJAX=True',
                'multi'            : false,
                'method'           : 'post',
                'fileObjName'      : 'ImageFile',
                'formData'         : { "SliderId": <%=TheLanternSlide.SlideId%>, "__AdminAuth" : ADMIN_AUTH },
                'queueSizeLimit'   : 1,
                'fileSizeLimit'    : '2MB',
                'buttonText'       : '<%=LangRes.Text("SelectImageFiles") %>',
                'fileTypeExts'     : '*.gif; *.jpg; *.png',
                'onUploadSuccess'  : function (file, data, response) {
                    var jsonData = $.parseJSON(data);
                    var imgPath = jsonData["Data"];
                    $("#SliderImagePanel").show();
                    $("#SliderImageLink").attr("href", WEB_ROOT + imgPath);
                    $("#SliderImage").attr("src", WEB_ROOT + imgPath);
                },
                'width'            : 120,
                'height'           : 30
            });
        });
    </script>
</body>
</html>
