<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.AddAttributePage" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/product-min.js?v=20131226"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("AddProductAttributeData") %></strong>
                    <span><a href="<%=ADMIN_URL("ProductAttributeManagerPage") %>" class="more_link"><%=LangRes.Text("ManageList") %></a></span>
                </div>
                <div class="main_content">
                    <form id="EditorForm" action="<%=API_URL("AdminProductHandler") %>?action=200" method="post" enctype="application/x-www-form-urlencoded">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label for="txtAttributeName"><%=LangRes.Text("Name") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtAttributeName" name="Name" class="txt" maxlength="250" /></td>

                                <th class="title" style="width:15%;"><label for="txtAttributeTitle"><%=LangRes.Text("Title") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtAttributeTitle" name="Title" class="txt" maxlength="250" /></td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectAttributeType"><%=LangRes.Text("Type") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectAttributeType" name="Type" class="select">
                                    <%  foreach (string name in Enum.GetNames(typeof(AttributeGroupTypes))){  %>
                                        <option value="<%=name %>"><%=LangRes.Text(name + "AttributeType") %></option>
                                    <%  }  %>
                                    </select>
                                </td>

                                <th class="title" style="width:15%;"><label for="txtAttributeSortOrder"><%=LangRes.Text("SortOrder") %>:</label></th>
                                <td class="field" style="width:35%;"><input type="text" id="txtAttributeSortOrder" name="SortOrder" class="txt" maxlength="3" /></td>
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
                                    <input type="submit" value="<%=LangRes.Text("AddProductAttributeData") %>" class="submit" />
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
        var TextTips = new FormTextTip({
            "txtAttributeName": "<%=LangRes.Text("NameForShow") %>",
            "txtAttributeTitle": "<%=LangRes.Text("TitleForMouseHover") %>",
            "txtAttributeSortOrder": "<%=LangRes.Text("ValueMoreLessPriorityHigher") %>"
        }, "txt_tip");

        <%if(ActionResult.Data != null){%>
        var TempAttributeJson = <%=ActionResult.Data %>;
        
        for(var prpName in TempAttributeJson){
            var prpValue = TempAttributeJson[prpName];
            if(prpValue != null && prpValue != ""){
                $("input[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
                $("textarea[name='" + prpName + "']").val(prpValue).removeClass("txt_tip");
            }
        }
        <%}%>
    </script>
</body>
</html>
