<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AddProductPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <link href="<%=WebRoot %>Scripts/jquery.uploadify/uploadify.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery.uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="<%=WebRoot %>Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131231"></script>

<!-- #include file="../includes/_editor.html" -->
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("AddProductData") %></strong>
                    <span><a href="<%=ADMIN_URL("ProductManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("ProductAttributeManagerPage") %>" class="more_link"><%=LangRes.Text("ManageProductAttribute") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminProductHandler") %>?action=100" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
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
                                <th class="title" style="width:15%;"><label for="txtProductName"><%=LangRes.Text("ProductName") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtProductName" name="Name" class="txt" maxlength="100" /></td>

                                <th class="title" style="width:15%;"><label for="selectProductCategoryId"><%=LangRes.Text("ProductCategory") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectProductCategoryId" name="CategoryId" class="select" onchange="LoadChildCategoryList('<%=API_URL("AdminCategoryHandler") %>?action=200&CategoryId=' + $(this).val(),'selectProductLevel2CategoryId', {'0': '<%=LangRes.Text("SelectBelongLevel2Category") %>'});">
                                        <option value="0"><%=LangRes.Text("SelectBelongCategory") %></option>
                                    <% foreach(Category category in RootCategoryList){ %>
                                        <option value="<%=category.CategoryId %>"><%=category.Name %>(<%=category.UrlName %>)</option>
                                    <% } %>
                                    </select>
                                    <select id="selectProductLevel2CategoryId" name="Level2CategoryId" class="select">
                                        <option value="0"><%=LangRes.Text("SelectBelongLevel2Category") %></option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="txtProductThumbFile"><%=LangRes.Text("ProductThumb") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <% if(TempThumbFile != null){ %>
                                    <div id="ThumbImagePanel" class="product_img">
                                        <a id="ThumbImageLink" href="<%=TempThumbFile.WebPath %>" target="_blank"><img id="ThumbImage" src="<%=TempThumbFile.WebPath %>" alt="<%=TempThumbFile.WebPath %>" /><span class="delete_icon" onclick="DeleteProductThumb('<%=API_URL("AdminProductHandler") %>?action=103', '<%=LangRes.Text("ConfirmToDelete") %>');return false;">&nbsp;</span></a>
                                    </div>
                                    <% } else { %>
                                    <div id="ThumbImagePanel" class="product_img none">
                                        <a id="ThumbImageLink" href="" target="_blank"><img id="ThumbImage" src="" alt="" /><span class="delete_icon" onclick="DeleteProductThumb('<%=API_URL("AdminProductHandler") %>?action=103', '<%=LangRes.Text("ConfirmToDelete") %>');return false;">&nbsp;</span></a>
                                    </div>
                                    <% } %>
                                    <div>
                                        <input type="file" id="txtProductThumbFile" name="ThumbFile" class="txt" />
                                        <div class="desc"><%=LangRes.Text("UploadProductThumbFileNotes") %></div>
                                        <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<%=CurrentSkin.ProductThumbSize %></div>
                                    </div>
                                </td>
                                <th class="title" style="width:15%;"><label for="txtProductLogoFile"><%=LangRes.Text("ProductLogo") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <% if(TempLogoFile != null){ %>
                                    <div id="LogoImagePanel" class="product_img">
                                        <a id="LogoImageLink" href="<%=TempLogoFile.WebPath %>" target="_blank"><img id="LogoImage" src="<%=TempLogoFile.WebPath %>" alt="<%=TempLogoFile.WebPath %>" /><span class="delete_icon" onclick="DeleteProductLogo('<%=API_URL("AdminProductHandler") %>?action=104', '<%=LangRes.Text("ConfirmToDelete") %>');return false;">&nbsp;</span></a>
                                    </div>
                                    <% } else { %>
                                    <div id="LogoImagePanel" class="product_img none">
                                        <a id="LogoImageLink" href="" target="_blank"><img id="LogoImage" src="" alt="" /><span class="delete_icon" onclick="DeleteProductLogo('<%=API_URL("AdminProductHandler") %>?action=104', '<%=LangRes.Text("ConfirmToDelete") %>');return false;">&nbsp;</span></a>
                                    </div>
                                    <% } %>
                                    <div>
                                        <input type="file" id="txtProductLogoFile" name="LogoFile" class="txt" />
                                        <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<%=CurrentSkin.ProductLogoSize %></div>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtProductDetail"><%=LangRes.Text("ProductIntro") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtProductDetail" name="Detail" rows="20" cols="60" class="txt"></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><%=LangRes.Text("Attach") %>:</th>
                                <td class="field" colspan="3">
                                    <ul id="ProductAttachList" class="attach_list">
                                    <% foreach(AttachFile attach in TempAttachList){ %>
                                        <li id="AttachListItem_<%=attach.AttachId %>">
                                            <div id="AttachItemPanel_<%=attach.AttachId %>">
                                                <a id="linkAttachName_<%=attach.AttachId %>" href="javascript:void(0);" target="_blank" onclick="return ShowAttachRenamePanel(<%=attach.AttachId %>);" class="name"><%=attach.FullName %></a>
                                                &nbsp;
                                                <a href="<%=attach.WebPath %>" target="_blank" class="tool_btn"><%=LangRes.Text("View") %></a>
                                                &nbsp;
                                                <a href="javascript:void(0);" class="tool_btn" onclick="return InsertAttachToEditor('txtProductDetail', '<%=attach.WebPath %>', '<%=attach.Name %>');"><%=LangRes.Text("Insert") %></a>
                                                &nbsp;
                                                <a id="btnDeleteAttach_<%=attach.AttachId %>" class="tool_btn delete_attach_btn" href="<%=API_URL("AdminAttachHandler") %>?action=112&AttachId=<%=attach.AttachId %>"><%=LangRes.Text("Delete") %></a>
                                            </div>
                                            <div id="AttachRenamePanel_<%=attach.AttachId %>" class="none"><input type="text" id="AttachName_<%=attach.AttachId %>" name="AttachName_<%=attach.AttachId %>" class="rename" onblur="RenameAttach(<%=attach.AttachId %>, '<%=API_URL("AdminAttachHandler") %>?action=111');" value="<%=attach.Name %>" /></div>
                                        </li>
                                    <% } %>
                                    </ul>

                                    <div>
                                        <input type="file" id="AttachFile" name="AttachFile" class="txt" />
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <th class="title"><label for="txtProductPublicTime"><%=LangRes.Text("PublicTime") %>:</label></th>
                                <td class="field">
                                    <input type="text" id="txtProductPublicTime" name="PublicTime" class="txt date" onclick="WdatePicker();" value="<%=Helper.DATE(Globals.Now) %>" />
                                </td>
                                <th class="title">&nbsp;</th>
                                <td class="field">&nbsp;</td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectProductEnableComment"><%=LangRes.Text("EnableComment") %>:</label></th>
                                <td class="field">
                                    <select id="selectProductEnableComment" name="EnableComment" class="select">
                                        <option value="False"><%=LangRes.Text("No") %></option>
                                        <option value="True"><%=LangRes.Text("Yes") %></option>
                                    </select>
                                </td>
                                <th class="title"><label for="selectProductRecommend"><%=LangRes.Text("RecommendToHomePage") %>:</label></th>
                                <td class="field">
                                    <select id="selectProductRecommend" name="Recommend" class="select">
                                        <option value="False"><%=LangRes.Text("No") %></option>
                                        <option value="True"><%=LangRes.Text("Yes") %></option>
                                    </select>
                                </td>
                            </tr>

                            <% if(AllAttributeGroupDic.Count > 0){ %>
                            <tr>
                                <th class="title"><label><%=LangRes.Text("ProductAttribute") %>:</label></th>
                                <td class="field" colspan="3">
                                    <ul id="ProductAttributeList">

                                    </ul>

                                    <script type="text/javascript">
                                        var productAttributeBuilder = null;
                                        $(function () {
                                            productAttributeBuilder = new ProductAttributeBuilder('ProductAttributeItemTemplate', 'ProductAttributeList');

                                            ClickAddProductAttributePanelBtn(productAttributeBuilder);
                                            InitShowOrHideAttributeGroupValueInput(1);
                                            productAttributeBuilder.WriteIndexesCookie(1);
                                        });
                                    </script>
                                    <div id="add_product_attribute_panel">
                                        <script type="text/html" id="ProductAttributeItemTemplate">
                                            <li id="ProductAttributePanel_${index}" class="item">
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <label>
                                                                <select id="ProductAttributeGroupId_${index}" name="ProductAttributeGroupId_${index}">
                                                                <% 
                                                                    foreach (KeyValuePair<int, AttributeGroup> attributeItem in AllAttributeGroupDic)
                                                                    {
                                                                        AttributeGroup attribute = attributeItem.Value;
                                                                %>
                                                                    <option value="<%=attribute.AttributeGroupId %>" title="<%=attribute.Title %>" data="<%=attribute.Type %>"><%=attribute.Name %></option>
                                                                <% } %>
                                                                </select>
                                                            </label>
                                                        </td>
                                                        <td>
                                                            <div id="ProductAttributeVarChar_${index}" class="input_div"><input type="text" id="ProductAttributeVarCharValue_${index}" name="ProductAttributeVarCharValue_${index}" class="input_value" /></div>
                                                            <div id="ProductAttributeInteger_${index}" class="input_div none"><input type="text" id="ProductAttributeIntegerValue_${index}" name="ProductAttributeIntegerValue_${index}" class="input_value number" /></div>
                                                            <div id="ProductAttributeNumber_${index}" class="input_div none"><input type="text" id="ProductAttributeNumberValue_${index}" name="ProductAttributeNumberValue_${index}" class="input_value number" /></div>
                                                            <div id="ProductAttributeDateTime_${index}" class="input_div none"><input type="text" id="ProductAttributeDateTimeValue_${index}" name="ProductAttributeDateTimeValue_${index}" class="input_value date" onclick="WdatePicker();" value="<%=Helper.DATE(Globals.Now) %>" /></div>
                                                            <div id="ProductAttributeBoolean_${index}" class="input_div none"><select id="ProductAttributeBooleanValue_${index}" name="ProductAttributeBooleanValue_${index}" class="input_value">
                                                                <option value="True"><%=LangRes.Text("Yes") %></option>
                                                                <option value="False"><%=LangRes.Text("No") %></option>
                                                            </select></div>

                                                            <div id="ProductAttributeText_${index}" class="input_div none"><textarea id="ProductAttributeTextValue_${index}" name="ProductAttributeTextValue_${index}" class="input_value" cols="55" rows="3"></textarea></div>

                                                        </td>
                                                        <td>
                                                            <a href="javascript:void(0);" onclick="productAttributeBuilder.RemoveProductAttributePanel('ProductAttributePanel_${index}','${index}');return false;" class="item_delete"><%=LangRes.Text("Delete") %>-</a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </li>  
                                        </script>

                                        <input type="hidden" id="ProductAttributePanelIndexes" name="ProductAttributePanelIndexes" value="1" />
                                        <a href="javascript:void(0);" onclick="ClickAddProductAttributePanelBtn(productAttributeBuilder);return false;" class="btn_add_attribute"><%=LangRes.Text("AddAttribute") %>+</a>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("AddProductData") %>" class="submit" />
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
            var TempCategoryJson = <%=ActionResult.Data %>;
        
            for(var prpName in TempCategoryJson){
                var prpValue = TempCategoryJson[prpName];
                if(prpValue != null && prpValue != ""){
                    $("input[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                    $("textarea[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                }
            }
            <%}%>

            InitEditor('txtProductDetail');

            BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");

            $("#txtProductThumbFile").uploadify({
                'swf'           : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'      : '<%=API_URL("AdminAttachHandler") %>?action=100&__AJAX=True',
                'multi'         : false,
                'method'        : 'post',
                'fileObjName'   : 'ThumbFile',
                'formData'      : {"ProductId" : 0, "__AdminAuth" : ADMIN_AUTH },
                'queueSizeLimit': 1,
                'fileSizeLimit' : '2MB',
                'buttonText'    : '<%=LangRes.Text("SelectImageFiles") %>',
                'fileTypeExts'  : '*.gif; *.jpg; *.png', 
                'onUploadSuccess': function(file, data, response) {
                    var jsonData = $.parseJSON(data);
                    var imgPath = jsonData["Data"];
                    $("#ThumbImagePanel").show();
                    $("#ThumbImageLink").attr("href", WEB_ROOT + imgPath);
                    $("#ThumbImage").attr("src", WEB_ROOT + imgPath);
                },
                'width'         : 120,
                'height'        : 30
            }); 
            $("#txtProductLogoFile").uploadify({
                'swf'           : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'      : '<%=API_URL("AdminAttachHandler") %>?action=101&__AJAX=True',
                'multi'         : false,
                'method'        : 'post',
                'fileObjName'   : 'LogoFile',
                'formData'      : {"ProductId" : 0, "__AdminAuth" : ADMIN_AUTH},
                'queueSizeLimit': 1,
                'fileSizeLimit' : '2MB',
                'buttonText'    : '<%=LangRes.Text("SelectImageFiles") %>',
                'fileTypeExts'  : '*.gif; *.jpg; *.png', 
                'onUploadSuccess': function(file, data, response) {
                    $("#LogoImagePanel").show();
                    var jsonData = $.parseJSON(data);
                    var imgPath = jsonData["Data"];
                    $("#LogoImagePanel").show();
                    $("#LogoImageLink").attr("href", WEB_ROOT + imgPath);
                    $("#LogoImage").attr("src", WEB_ROOT + imgPath);
                },
                'width'         : 120,
                'height'        : 30
            }); 
        
            $("#AttachFile").uploadify({
                'swf'           : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'      : '<%=API_URL("AdminAttachHandler") %>?action=110&__AJAX=True',
                'multi'         : true,
                'method'        : 'post',
                'fileObjName'   : 'AttachFile',
                'formData'      : {"TargetId" : 0, "BelongType" : "<%=AttachBelongTypes.Product %>", "__AdminAuth" : ADMIN_AUTH},
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
                    ParseTemplate('AttachItemTemplate', 'ProductAttachList', {"AttachId" : attachId, "WebPath" : attachWebPath, "FileExt" : attachExt, "Name" : attachName, "FullName" : attachFullName});

                    BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");
                },
                'width'         : 120,
                'height'        : 30
            });
        });
    </script>
</body>
</html>
