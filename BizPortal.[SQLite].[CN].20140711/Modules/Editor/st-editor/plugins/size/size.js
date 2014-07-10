//font size plugin
STEditor.Plugins["size"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/size/';

        editor.loadSelection();

        var inputId = editor.TargetId + "_EditorText_size";
        var okBtnId = editor.TargetId + "_EditorOkBtn_size";
        var cancelBtnId = editor.TargetId + "_EditorCancelBtn_size";

        var html = '<div class="STEditor_Common_Table">\n';
        html += '\t<div class="title">' + editor.getLang("PleaseInputFontSize") + editor.getLang("Colon") + '</div>\n';
        html += '\t<div class="item"><input id="' + inputId + '" type="text" value="12px" class="text" ondblclick="this.select();" /></div>\n';
        html += '\t<div class="tool"><input id="' + okBtnId + '" type="button" value="' + editor.getLang("OK") + '" class="btn" />&nbsp;<input id="' + cancelBtnId + '" type="button" value="' + editor.getLang("Cancel") + '" class="btn" /></div>\n';
        html += '</div>';
        editor.buildMaskPanel(html);

        var input = STEditor.getObject(inputId);
        var okBtn = STEditor.getObject(okBtnId);
        var cancelBtn = STEditor.getObject(cancelBtnId);

        STEditor.attachEvent(okBtn, "click", function (event) {
            STEditor.Plugins["size"]["Callback"](editor, input.value);
        });

        STEditor.attachEvent(cancelBtn, "click", function (event) {
            editor.closeMaskPanel();
        });
    },
    "Callback": function (editor, commandParameters) {
        editor.closeMaskPanel();
        editor.reselectRange();
        var text = editor.htmlEncode(editor.RangeText);
        editor.insertHTML('<span style="font-size:' + commandParameters + ';">' + text + '</span>');
    },
    "UBBToXHTML": function (input, editor) {
        var batchReplacement = [
            [/\[size=([^\[]*?)\]([^\[]*?)\[\/size\]/igm, '<span style="font-size:$1;">$2</span>', true]
        ]; // [ubb pattern, html replacement, has embed tags]

        return batchReplacement;
    },
    "XHTMLToUBB": function (input, editor) {
        var batchReplacement = [
            [/<span[^>]*?style\s*=\s*"font-size:\s*([^>]*?);?"[^>]*?>([^<]*?)<\/span>/igm, function ($0, $1, $2) {
                var str = $2;
                str = '[size=' + $1 + ']' + str + '[/size]';
                return str;
            }, true]
        ];  // [html pattern, ubb replacement, has embed tags]

        return batchReplacement;
    }
};