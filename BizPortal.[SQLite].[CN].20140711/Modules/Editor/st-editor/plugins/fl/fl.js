//flash plugin
STEditor.Plugins["fl"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/fl/';
        editor.loadSelection();

        var inputId = editor.TargetId + "_EditorText_fl";
        var okBtnId = editor.TargetId + "_EditorOkBtn_fl";
        var cancelBtnId = editor.TargetId + "_EditorCancelBtn_fl";

        var html = '<div class="STEditor_Common_Table">\n';
        html += '\t<div class="title">' + editor.getLang("PleaseInputFlashUrl") + editor.getLang("Colon") + '</div>\n';
        html += '\t<div class="item"><input id="' + inputId + '" type="text" value="http://" class="text" ondblclick="this.select();" /></div>\n';
        html += '\t<div class="tool"><input id="' + okBtnId + '" type="button" value="' + editor.getLang("OK") + '" class="btn" />&nbsp;<input id="' + cancelBtnId + '" type="button" value="' + editor.getLang("Cancel") + '" class="btn" /></div>\n';
        html += '</div>';
        editor.buildMaskPanel(html);

        var input = STEditor.getObject(inputId);
        var okBtn = STEditor.getObject(okBtnId);
        var cancelBtn = STEditor.getObject(cancelBtnId);

        STEditor.attachEvent(okBtn, "click", function (event) {
            STEditor.Plugins["fl"]["Callback"](editor, input.value);
        });

        STEditor.attachEvent(cancelBtn, "click", function (event) {
            editor.closeMaskPanel();
        });
    },
    "Callback": function (editor, commandParameters) {
        editor.closeMaskPanel();
        editor.reselectRange();

        var html = editor.RangeText;
        html += '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="500" height="500">';
        html += '<param name="movie" value="' + commandParameters + '" />';
        html += '<param name="quality" value="high" />';
        html += '<param name="wmode" value="opaque" />';
        html += '<embed src="' + commandParameters + '" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="500" height="500"></embed>';
        html += '</object>';

        editor.insertHTML(html);
    },
    "UBBToXHTML": function (input, editor) {
        var batchReplacement = [
            [/\[flash\]([^\[]*?)\[\/flash\]/igm, '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="500" height="500"><param name="movie" value="$1" /><param name="quality" value="high" /><param name="wmode" value="opaque" /><embed src="$1" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="500" height="500"></embed></object>', true]
        ]; // [ubb pattern, html replacement, has embed tags]

        return batchReplacement;
    },
    "XHTMLToUBB": function (input, editor) {
        var batchReplacement = [
            [/<object[^>]*?classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"[^>]*>.*?<param[^>]*?value="([^>]+?)"[^>]*?name="movie"[^>]*?>.*?<\/object>/igm, function ($0, $1) {
                var url = $1;
                var str = '[flash]' + url + '[/flash]';
                return str;
            }, true],
            [/<object[^>]*?classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"[^>]*>.*?<param[^>]*?name="movie"[^>]*?value="([^>]+?)"[^>]*?>.*?<\/object>/igm, function ($0, $1) {
                var url = $1;
                var str = '[flash]' + url + '[/flash]';
                return str;
            }, true],
            [/<embed[^>]*?src="([^>]+?)"[^>]*?type="application\/x-shockwave-flash"[^>]*?>/igm, function ($0, $1) {
                var url = $1;
                var str = '[flash]' + url + '[/flash]';
                return str;
            }, true],
            [/<embed[^>]*?type="application\/x-shockwave-flash"[^>]*?src="([^>]+?)"[^>]*?>/igm, function ($0, $1) {
                var url = $1;
                var str = '[flash]' + url + '[/flash]';
                return str;
            }, true]
        ];  // [html pattern, ubb replacement, has embed tags]

        return batchReplacement;
    }
};