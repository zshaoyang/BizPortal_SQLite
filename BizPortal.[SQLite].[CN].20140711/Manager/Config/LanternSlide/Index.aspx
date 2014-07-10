<%@ Page Language="C#" AutoEventWireup="false" Inherits="BizPortal.AdminUI.LanternSlidePage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="../../includes/_meta.html" -->
    <script type="text/javascript" src="<%=AdminRoot %>js/config-min.js?v=20131231"></script>
</head>
<body id="body">
    <div class="stage">

<!-- #include file="../../includes/_header.html" -->

        <div id="main">
            <div class="inner">
                <div class="main_title">
                    <strong><%=LangRes.Text("ManageLanternSlideData") %></strong>
                    <span><a href="<%=ADMIN_URL("AddSliderPage") %>" class="more_link"><%=LangRes.Text("AddLanternSlideData") %>+</a></span>
                    <span><a href="<%=ADMIN_URL("DisplayConfigPage") %>" class="more_link"><%=LangRes.Text("DisplaySetting") %></a></span>
                </div>
                <div class="main_content">
                    <div id="ActionMessageBox" class="action_msg <%=ActionResult.Result %><%=Helper.IF(ActionResult.Result == PageActionResultType.Default, " none") %>"><%=ActionResult.Message %></div>

                    <form id="EditorForm" action="<%=API_URL("AdminConfigHandler") %>?action=700" method="post" enctype="multipart/form-data" onsubmit="$('#SubmitButton').attr('disabled',true);">
                    <table class="editor_table" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <th class="title" style="width:15%;"><label for="selectAutoPlay"><%=LangRes.Text("IfSliderAutoPlay") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectAutoPlay" name="AutoPlay" class="select" onchange="YesOrNoShowOrHide('selectAutoPlay', 'AutoPlaySettingPanel');">
                                        <option value="True" <%=Helper.SELECTED("AutoPlay", true, SliderSetting.AutoPlay) %>><%=LangRes.Text("Yes") %></option>
                                        <option value="False" <%=Helper.SELECTED("AutoPlay", false, SliderSetting.AutoPlay) %>><%=LangRes.Text("No") %></option>
                                    </select>

                                    <div id="AutoPlaySettingPanel">
                                        <label for="txtPlaySpeed"><%=LangRes.Text("SliderPlaySpeed") %>:</label>
                                        <input type="text" id="txtPlaySpeed" name="PlaySpeed" maxlength="5" class="txt number" value="<%=SliderSetting.PlaySpeed %>" />
                                        <br /><span class="desc"><%=LangRes.Text("SliderPlaySpeedNote") %></span>
                                    </div>
                                </td>

                                <th class="title" style="width:15%;"><label for="selectSlideMode"><%=LangRes.Text("UseSlidingMode") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectSlideMode" name="SlideMode" class="select" onchange="YesOrNoShowOrHide('selectSlideMode', 'SlideModeSettingPanel');">
                                        <option value="True" <%=Helper.SELECTED("SlideMode", true, SliderSetting.SlideMode) %>><%=LangRes.Text("Yes") %></option>
                                        <option value="False" <%=Helper.SELECTED("SlideMode", false, SliderSetting.SlideMode) %>><%=LangRes.Text("No") %></option>
                                    </select>
                                    <br /><span class="desc"><%=LangRes.Text("UseSlidingModeNote") %></span>

                                    <div id="SlideModeSettingPanel">
                                        <label for="selectSlideDirection"><%=LangRes.Text("SlidingDirection") %>:</label>
                                        <select id="selectSlideDirection" name="SlideDirection" class="select">
                                            <option value="1" <%=Helper.SELECTED("SlideDirection", 1, SliderSetting.SlideDirection) %>><%=LangRes.Text("SlidingDirectionHorizontal") %></option>
                                            <option value="2" <%=Helper.SELECTED("SlideDirection", 2, SliderSetting.SlideDirection) %>><%=LangRes.Text("SlidingDirectionVertical") %></option>
                                        </select>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <th class="title" style="width:15%;"><label for="selectShowCaption"><%=LangRes.Text("IfSliderTitleShow") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectShowCaption" name="ShowCaption" class="select">
                                        <option value="True" <%=Helper.SELECTED("ShowCaption", true, SliderSetting.ShowCaption) %>><%=LangRes.Text("Yes") %></option>
                                        <option value="False" <%=Helper.SELECTED("ShowCaption", false, SliderSetting.ShowCaption) %>><%=LangRes.Text("No") %></option>
                                    </select>
                                </td>

                                <th class="title" style="width:15%;">&nbsp;</th>
                                <td class="field" style="width:35%;">&nbsp;</td>
                            </tr>
                            
                            <tr>
                                <th class="title" style="width:15%;"><label for="selectShowNumberButtons"><%=LangRes.Text("IfSliderNumberButtonsShow") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectShowNumberButtons" name="ShowNumberButtons" class="select">
                                        <option value="True" <%=Helper.SELECTED("ShowNumberButtons", true, SliderSetting.ShowNumberButtons) %>><%=LangRes.Text("Yes") %></option>
                                        <option value="False" <%=Helper.SELECTED("ShowNumberButtons", false, SliderSetting.ShowNumberButtons) %>><%=LangRes.Text("No") %></option>
                                    </select>
                                    <br /><span class="desc"><%=LangRes.Text("IfSliderNumberButtonsShowNote") %></span>
                                </td>

                                <th class="title" style="width:15%;"><label for="selectShowArrowButtons"><%=LangRes.Text("IfSliderArrowButtonsShow") %>:</label></th>
                                <td class="field" style="width:35%;">
                                    <select id="selectShowArrowButtons" name="ShowArrowButtons" class="select">
                                        <option value="True" <%=Helper.SELECTED("ShowArrowButtons", true, SliderSetting.ShowArrowButtons) %>><%=LangRes.Text("Yes") %></option>
                                        <option value="False" <%=Helper.SELECTED("ShowArrowButtons", false, SliderSetting.ShowArrowButtons) %>><%=LangRes.Text("No") %></option>
                                    </select>
                                    <br /><span class="desc"><%=LangRes.Text("IfSliderArrowButtonsShowNote") %></span>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align:center;">
                                    <input type="submit" id="SubmitButton" value="<%=LangRes.Text("SaveSetting") %>" class="submit" />
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    </form>

                    <table class="list_table slider_list" cellpadding="0" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th><%=LangRes.Text("Name") %></th>
                                <th><%=LangRes.Text("Title") %></th>
                                <th><%=LangRes.Text("Link") %></th>
                                <th><%=LangRes.Text("SortOrder") %></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            foreach (LanternSlide slider in AllSliderList)
                            {
                        %>
                            <tr id="sliderItem_<%=slider.SlideId %>">
                                <td><%=slider.SlideId %></td>
                                <td><%=slider.Name %></td>
                                <td><%=slider.Title %></td>
                                <td><a href="<%=slider.Link %>" target="_blank"><%=slider.Link %></a></td>
                                <td><%=slider.SortOrder %></td>
                                <td>
                                    <a href="<%=ADMIN_URL("EditSliderPage", slider.SlideId) %>"><%=LangRes.Text("Edit") %></a>
                                    &nbsp;
                                    <a id="btnDeleteSlider_<%=slider.SlideId %>" class="btn_delete_slider" href="<%=API_URL("AdminConfigHandler") %>?action=212&SlideId=<%=slider.SlideId %>"><%=LangRes.Text("Delete") %></a>
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

<!-- #include file="../../includes/_footer.html" -->

    </div>
    <script type="text/javascript">
        $(function () {
            YesOrNoShowOrHide('selectAutoPlay', 'AutoPlaySettingPanel');
            YesOrNoShowOrHide('selectSlideMode', 'SlideModeSettingPanel');

            $("td .btn_delete_slider").each(function () {
                var btn = $(this);
                var btnId = btn.attr("id");

                btn.bind("click", function () {

                    QueryLinkAction(btnId, "<%=LangRes.Text("ConfirmToDeleteTheLanternSlide") %>", function (jsonData) {
                        var actionResult = parseInt(jsonData["Result"]);
                        var sliderId = jsonData["Data"];
                        var sliderItem = $("#sliderItem_" + sliderId);

                        sliderItem.fadeOut(400);
                        setTimeout(function () {
                            sliderItem.remove();
                        }, 500);

                        return true;
                    });
                    return false;
                });
            });
        });
    </script>
</body>
</html>
