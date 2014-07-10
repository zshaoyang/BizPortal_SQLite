<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AttributePage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131225"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageProductAttributeData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddProductAttributePage") %>" class="more_link"><%=LangRes.Text("AddProductAttributeData") %>+</a></span>
                </div>
                <div class="main_content">
                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>
                    <table class="list_table attribute_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th><%=LangRes.Text("Name") %></th>
                                <th><%=LangRes.Text("Title") %></th>
                                <th><%=LangRes.Text("Type") %></th>
                                <th><%=LangRes.Text("SortOrder") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach (KeyValuePair<int, AttributeGroup> attributeItem in AllAttributeGroupDic)
                            {
                                AttributeGroup attribute = attributeItem.Value;
                        %>
                            <tr id="attributeItem_<%=attribute.AttributeGroupId %>">
                                <td><%=attribute.AttributeGroupId %></td>
                                <td><a href="<%=ADMIN_URL("EditProductAttributePage", attribute.AttributeGroupId) %>"><%=attribute.Name %></a></td>
                                <td><a href="<%=ADMIN_URL("EditProductAttributePage", attribute.AttributeGroupId) %>"><%=attribute.Title %></a></td>
                                <td><%=LangRes.Text(attribute.Type + "AttributeType") %></td>
                                <td><%=attribute.SortOrder %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditProductAttributePage", attribute.AttributeGroupId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteAttribute_<%=attribute.AttributeGroupId %>" class="btn_delete_attribute" href="<%=API_URL("AdminProductHandler") %>?action=202&AttributeId=<%=attribute.AttributeGroupId %>"><%=LangRes.Text("Delete") %></a>
                                </td>
                            </tr>
                        <%
                            } 
                        %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="6">&nbsp;</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

<!-- #include file="../includes/_footer.html" -->

    </div>

    <script type="text/javascript">
        $(".attribute_list td .btn_delete_attribute").each(function () {
            var btn = $(this);
            var btnId = btn.attr("id");

            btn.bind("click", function () {
                QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheProductAttribute") %>", function (jsonData) {
                    var actionResult = parseInt(jsonData["Result"]);
                    var attributeId = jsonData["Data"];
                    var attributeItem = $("#attributeItem_" + attributeId);

                    attributeItem.fadeOut(400);
                    setTimeout(function () {
                        attributeItem.remove();
                    }, 500);

                    return true;
                });

                return false;
            });
        });
    </script>
</body>
</html>
