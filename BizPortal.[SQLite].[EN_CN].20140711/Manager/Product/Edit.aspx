<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.EditProductPage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <link href="<%=WebRoot %>Scripts/jquery.uploadify/uploadify.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="<%=WebRoot %>Scripts/jquery.uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="<%=WebRoot %>Scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131226"></script>

<!-- #include file="../includes/_editor.html" -->
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("UpdateProductData") %></strong>
                    <span><a href="<%=ADMIN_URL("ProductManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                    <span><a href="<%=ADMIN_URL("AddProductPage") %>" class="more_link"><%=LangRes.Text("AddProductData") %>+</a></span>
                    <span><a href="<%=ADMIN_URL("ProductAttributeManagerPage") %>" class="more_link"><%=LangRes.Text("ManageProductAttribute") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminProductHandler") %>?action=101" method="post" enctype="multipart/form-data">
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
                                <td class="field" style="width:35%;"><input type="text" id="txtProductName" name="Name" class="txt" maxlength="100" value="<%=TheProduct.Name %>" /></td>

                                <th class="title" style="width:15%;"><label for="selectProductCategoryId"><%=LangRes.Text("ProductCategory") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectProductCategoryId" name="CategoryId" class="select" onchange="LoadChildCategoryList('<%=API_URL("AdminCategoryHandler") %>?action=200&CategoryId=' + $(this).val(),'selectProductLevel2CategoryId', {'0': '<%=LangRes.Text("SelectBelongLevel2Category") %>'});">
                                        <option value="0"><%=LangRes.Text("SelectBelongCategory") %></option>
                                    <% foreach(Category category in RootCategoryList){ %>
                                        <option value="<%=category.CategoryId %>" <%=Helper.SELECTED("CategoryId", category.CategoryId, TheProduct.CategoryId) %>><%=category.Name %>(<%=category.UrlName %>)</option>
                                    <% } %>
                                    </select>
                                    <select id="selectProductLevel2CategoryId" name="Level2CategoryId" class="select">
                                        <option value="0"><%=LangRes.Text("SelectBelongLevel2Category") %></option>
                                    <% 
                                    if(TheProduct.CategoryId > 0){    
                                        foreach(Category level2Category in TheProduct.Category.ChildCategoryList){
                                    %>
                                        <option value="<%=level2Category.CategoryId %>" <%=Helper.SELECTED("Level2CategoryId", level2Category.CategoryId, TheProduct.Level2CategoryId) %>><%=level2Category.Name %>(<%=level2Category.UrlName %>)</option>
                                    <% 
                                        }
                                    }    
                                    %>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtProductThumbFile"><%=LangRes.Text("ProductThumb") %>:</label></th>
                                <td class="field">
                                    <div id="ThumbImagePanel" class="product_img<%=Helper.IF(string.IsNullOrEmpty(TheProduct.Thumb), " none") %>">
                                        <a id="ThumbImageLink" href="<%=TheProduct.ThumbWebPath %>" target="_blank"><img id="ThumbImage" src="<%=TheProduct.ThumbWebPath %>" alt="<%=TheProduct.ThumbWebPath %>" /><span class="delete_icon" onclick="DeleteProductThumb('<%=API_URL("AdminProductHandler") %>?action=103&ProductId=<%=TheProduct.ProductId %>', '<%=LangRes.Text("ConfirmToDelete") %>');return false;">&nbsp;</span></a>
                                    </div>
                                    <div>
                                        <input type="file" id="txtProductThumbFile" name="ThumbFile" class="txt" />
                                        <div class="desc"><%=LangRes.Text("UploadProductThumbFileNotes") %></div>
                                        <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<%=CurrentSkin.ProductThumbSize %></div>
                                    </div>
                                </td>
                                <th class="title"><label for="txtProductLogoFile"><%=LangRes.Text("ProductLogo") %>:</label></th>
                                <td class="field">
                                    <div id="LogoImagePanel" class="product_img<%=Helper.IF(string.IsNullOrEmpty(TheProduct.Logo), " none") %>">
                                        <a id="LogoImageLink" href="<%=TheProduct.LogoWebPath %>" target="_blank"><img id="LogoImage" src="<%=TheProduct.LogoWebPath %>" alt="<%=TheProduct.LogoWebPath %>" /><span class="delete_icon" onclick="DeleteProductLogo('<%=API_URL("AdminProductHandler") %>?action=104&ProductId=<%=TheProduct.ProductId %>', '<%=LangRes.Text("ConfirmToDelete") %>');return false;">&nbsp;</span></a>
                                    </div>
                                    <div>
                                        <input type="file" id="txtProductLogoFile" name="LogoFile" class="txt" />
                                        <div class="desc"><%=LangRes.Text("OptimumSize") %>(<%=LangRes.Text("Pixels") %>):<%=CurrentSkin.ProductLogoSize %></div>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><label for="txtProductDetail"><%=LangRes.Text("ProductIntro") %>:</label></th>
                                <td class="field" colspan="3">
                                    <textarea id="txtProductDetail" name="Detail" rows="20" cols="60" class="txt"><%=DEnCodeHelper.HtmlEncode(TheProduct.Detail) %></textarea>
                                </td>
                            </tr>

                            <tr>
                                <th class="title"><%=LangRes.Text("Attach") %>:</th>
                                <td class="field" colspan="3">
                                    <ul id="ProductAttachList" class="attach_list">
                                    <% foreach(AttachFile attach in AttachList){ %>
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

                                    <script type="text/html" id="AttachItemTemplate">
                                        <li id="AttachListItem_${AttachId}">
                                            <div id="AttachItemPanel_${AttachId}">
                                                <a id="linkAttachName_${AttachId}" href="javascript:void(0);" target="_blank" onclick="return ShowAttachRenamePanel(${AttachId});" class="name">${FullName}</a>
                                                &nbsp;
                                                <a href="${WebPath}" target="_blank" class="tool_btn"><%=LangRes.Text("View") %></a>
                                                &nbsp;
                                                <a href="javascript:void(0);" class="tool_btn" onclick="return InsertAttachToEditor('txtProductDetail', '${WebPath}', '${Name}');"><%=LangRes.Text("Insert") %></a>
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
                                <th class="title"><label for="txtProductPublicTime"><%=LangRes.Text("PublicTime") %>:</label></th>
                                <td class="field">
                                    <input type="text" id="txtProductPublicTime" name="PublicTime" class="txt date" value="<%=Helper.DATETIME(TheProduct.PublicTime) %>" onclick="WdatePicker();" />
                                </td>
                                <th class="title">&nbsp;</th>
                                <td class="field">&nbsp;</td>
                            </tr>

                            <tr>
                                <th class="title"><label for="selectProductEnableComment"><%=LangRes.Text("EnableComment") %>:</label></th>
                                <td class="field">
                                    <select id="selectProductEnableComment" name="EnableComment" class="select">
                                        <option value="False" <%=Helper.SELECTED("EnableComment", false, TheProduct.EnableComment) %>><%=LangRes.Text("No") %></option>
                                        <option value="True" <%=Helper.SELECTED("EnableComment", true, TheProduct.EnableComment) %>><%=LangRes.Text("Yes") %></option>
                                    </select>
                                </td>
                                <th class="title"><label for="selectProductRecommend"><%=LangRes.Text("RecommendToHomePage") %>:</label></th>
                                <td class="field">
                                    <select id="selectProductRecommend" name="Recommend" class="select">
                                        <option value="False" <%=Helper.SELECTED("Recommend", false, TheProduct.Recommend) %>><%=LangRes.Text("No") %></option>
                                        <option value="True" <%=Helper.SELECTED("Recommend", true, TheProduct.Recommend) %>><%=LangRes.Text("Yes") %></option>
                                    </select>
                                </td>
                            </tr>

                            <% if(AllAttributeGroupDic.Count > 0){ %>
                            <tr>
                                <th class="title"><label><%=LangRes.Text("ProductAttribute") %>:</label></th>
                                <td class="field" colspan="3">
                                    <ul id="ProductAttributeList">
                                    <% StringBuffer AttributeIndexesBuilder = new StringBuffer("");
                                       for (int i = 0; i < AttributeList.Count; i++ )
                                       {
                                           ProductAttribute attribute = AttributeList[i];
                                           SetProductAttributeGroup(attribute);
                                           int index = i + 1;
                                           AttributeIndexesBuilder += index.ToString(); 
                                    %>
                                        <li id="ProductAttributePanel_<%=index %>" class="item">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <label>
                                                            <select id="ProductAttributeGroupId_<%=index %>" name="ProductAttributeGroupId_<%=index %>">
                                                            <% 
                                                                foreach (KeyValuePair<int, AttributeGroup> attributeItem in AllAttributeGroupDic)
                                                                {
                                                                    AttributeGroup attributeGroup = attributeItem.Value;
                                                            %>
                                                                <option value="<%=attributeGroup.AttributeGroupId %>" title="<%=attributeGroup.Title %>" data="<%=attributeGroup.Type %>" <%=Helper.SELECTED("ProductAttributeGroupId_" + index, attributeGroup.AttributeGroupId, attribute.AttributeGroupId) %>><%=attributeGroup.Name %></option>
                                                            <% } %>
                                                            </select>
                                                        </label>
                                                    </td>
                                                    <td>
                                                        <div id="ProductAttributeVarChar_<%=index %>" class="input_div"><input type="text" id="ProductAttributeVarCharValue_<%=index %>" name="ProductAttributeVarCharValue_<%=index %>" class="input_value" value="<%=Helper.IF(attribute.AttributeGroup.Type != AttributeGroupTypes.Text, attribute.Value) %>" /></div>
                                                        <div id="ProductAttributeInteger_<%=index %>" class="input_div none"><input type="text" id="ProductAttributeIntegerValue_<%=index %>" name="ProductAttributeIntegerValue_<%=index %>" class="input_value number" value="<%=Helper.IF(attribute.AttributeGroup.Type != AttributeGroupTypes.Text, attribute.Value) %>" /></div>
                                                        <div id="ProductAttributeNumber_<%=index %>" class="input_div none"><input type="text" id="ProductAttributeNumberValue_<%=index %>" name="ProductAttributeNumberValue_<%=index %>" class="input_value number" value="<%=Helper.IF(attribute.AttributeGroup.Type != AttributeGroupTypes.Text, attribute.Value) %>" /></div>
                                                        <div id="ProductAttributeDateTime_<%=index %>" class="input_div none"><input type="text" id="ProductAttributeDateTimeValue_<%=index %>" name="ProductAttributeDateTimeValue_<%=index %>" class="input_value date" onclick="WdatePicker();" value="<%=Helper.IF(attribute.AttributeGroup.Type != AttributeGroupTypes.Text, attribute.Value) %>" /></div>
                                                        <div id="ProductAttributeBoolean_<%=index %>" class="input_div none"><select id="ProductAttributeBooleanValue_<%=index %>" name="ProductAttributeBooleanValue_<%=index %>" class="input_value">
                                                            <option value="True" <%=Helper.SELECTED("ProductAttributeBooleanValue_" + index, "True", attribute.Value) %>><%=LangRes.Text("Yes") %></option>
                                                            <option value="False" <%=Helper.SELECTED("ProductAttributeBooleanValue_" + index, "False", attribute.Value) %>><%=LangRes.Text("No") %></option>
                                                        </select></div>

                                                        <div id="ProductAttributeText_<%=index %>" class="input_div none"><textarea id="ProductAttributeTextValue_<%=index %>" name="ProductAttributeTextValue_<%=index %>" class="input_value" cols="55" rows="3"><%=DEnCodeHelper.HtmlEncode(attribute.Value) %></textarea></div>

                                                    </td>
                                                    <td>
                                                        <a id="btnDeleteProductAttribute_<%=index %>" href="javascript:void(0);" onclick="DeleteProductAttribute('<%=API_URL("AdminProductHandler") %>?action=106&ProductAttributeId=<%=attribute.ProductAttributeId %>&ProductId=<%=attribute.ProductId %>', productAttributeBuilder, <%=index %>); return false;" class="item_delete"><%=LangRes.Text("Delete") %>-</a>
                                                    </td>
                                                </tr>
                                            </table>

                                            <input type="hidden" id="ProductAttributeId_<%=index %>" name="ProductAttributeId_<%=index %>" value="<%=attribute.ProductAttributeId %>" />
                                            <script type="text/javascript">
                                                $(function(){
                                                    InitShowOrHideAttributeGroupValueInput(<%=index %>);   
                                                });
                                            </script>
                                        </li>
                                    <% } %>
                                    </ul>

                                    <script type="text/javascript">
                                        var productAttributeBuilder = null;
                                        $(function () {
                                            productAttributeBuilder = new ProductAttributeBuilder('ProductAttributeItemTemplate', 'ProductAttributeList');
                                            productAttributeBuilder.WriteIndexesCookie(<%=AttributeList.Count %>);
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
                                        <input type="hidden" id="ProductAttributePanelIndexes" name="ProductAttributePanelIndexes" value="<%=AttributeIndexesBuilder.ToString() %>" />
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
                                    <input type="hidden" id="ProductId" name="ProductId" value="<%=TheProduct.ProductId %>" />
                                    <input type="submit" value="<%=LangRes.Text("UpdateProductData") %>" class="submit" />
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
            InitEditor('txtProductDetail');

            BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");

            $("#txtProductThumbFile").uploadify({
                'swf'              : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'         : '<%=API_URL("AdminAttachHandler") %>?action=100&__AJAX=True',
                'multi'            : false,
                'method'           : 'post',
                'fileObjName'      : 'ThumbFile',
                'formData'         : { "ProductId": <%=TheProduct.ProductId%>, "__AdminAuth" : ADMIN_AUTH },
                'queueSizeLimit'   : 1,
                'fileSizeLimit'    : '2MB',
                'buttonText'       : '<%=LangRes.Text("SelectImageFiles") %>',
                'fileTypeExts'     : '*.gif; *.jpg; *.png',
                'onUploadSuccess'  : function (file, data, response) {
                    var jsonData = $.parseJSON(data);
                    var imgPath = jsonData["Data"];
                    $("#ThumbImagePanel").show();
                    $("#ThumbImageLink").attr("href", WEB_ROOT + imgPath);
                    $("#ThumbImage").attr("src", WEB_ROOT + imgPath);
                },
                'width'            : 120,
                'height'           : 30
            });
            $("#txtProductLogoFile").uploadify({
                'swf'              : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'         : '<%=API_URL("AdminAttachHandler") %>?action=101&__AJAX=True',
                'multi'            : false,
                'method'           : 'post',
                'fileObjName'      : 'LogoFile',
                'formData'         : { "ProductId": <%=TheProduct.ProductId%>, "__AdminAuth" : ADMIN_AUTH },
                'queueSizeLimit'   : 1,
                'fileSizeLimit'    : '2MB',
                'buttonText'       : '<%=LangRes.Text("SelectImageFiles") %>',
                'fileTypeExts'     : '*.gif; *.jpg; *.png',
                'onUploadSuccess'  : function (file, data, response) {
                    $("#LogoImagePanel").show();
                    var jsonData = $.parseJSON(data);
                    var imgPath = jsonData["Data"];
                    $("#LogoImagePanel").show();
                    $("#LogoImageLink").attr("href", WEB_ROOT + imgPath);
                    $("#LogoImage").attr("src", WEB_ROOT + imgPath);
                },
                'width'            : 120,
                'height'           : 30
            });

            $("#AttachFile").uploadify({
                'swf'               : '<%=WebRoot %>Scripts/jquery.uploadify/uploadify.swf',
                'uploader'          : '<%=API_URL("AdminAttachHandler") %>?action=110&__AJAX=True',
                'multi'             : true,
                'method'            : 'post',
                'fileObjName'       : 'AttachFile',
                'formData'          : { "TargetId": <%=TheProduct.ProductId%>, "BelongType": "<%=AttachBelongTypes.Product %>", "__AdminAuth" : ADMIN_AUTH },
                'queueSizeLimit'    : 5,
                'fileSizeLimit'     : '2MB',
                'buttonText'        : '<%=LangRes.Text("SelectAttachFiles") %>',
                'onUploadSuccess'   : function (file, data, response) {
                    var jsonData = $.parseJSON(data);
                    var obj = jsonData["Data"];
                    var attachId = obj["AttachId"];
                    var attachPath = obj["Path"];
                    var attachName = obj["Name"];
                    var attachExt = obj["FileExt"];
                    var attachFullName = attachName == '' ? attachName : (attachName + '.' + attachExt);
                    var attachWebPath = WEB_ROOT + attachPath;
                    ParseTemplate('AttachItemTemplate', 'ProductAttachList', { "AttachId": attachId, "WebPath": attachWebPath, "FileExt": attachExt, "Name": attachName, "FullName": attachFullName });

                    BindDeleteAttachFunction("<%=LangRes.Text("ConfirmToDeleteTheAttach") %>");
                },
                'width'             : 120,
                'height'            : 30
            });
        });
    </script>
</body>
</html>
