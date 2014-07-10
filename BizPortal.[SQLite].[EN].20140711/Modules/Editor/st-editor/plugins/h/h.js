//header format plugin
STEditor.Plugins["h"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/h/';
        var cssUrl = pluginBaseUrl + 'themes/' + editor.Skin + '/skin.css'
        STEditor.importStyleSheet(cssUrl);

        editor.loadSelection();
        var rangeText = editor.RangeText;
        if (!rangeText) {
            rangeText = editor.getLang('HeaderFormat') || editor.getLang('h_command');
        }

        var html = '<div class="STEditorHeaderFormatTable">';
        html += '\t<div class="title">' + editor.getLang("PleaseSelectHeaderFormat") + editor.getLang("Colon") + '</div>';
        html += '\t<div class="item">';
        html += '\t\t<h1 id="' + editor.TargetId + '_HeaderFormat1" class="header_format" data="h1">H1: ' + rangeText + '</h1>';
        html += '\t\t<h2 id="' + editor.TargetId + '_HeaderFormat2" class="header_format" data="h2">H2: ' + rangeText + '</h1>';
        html += '\t\t<h3 id="' + editor.TargetId + '_HeaderFormat3" class="header_format" data="h3">H3: ' + rangeText + '</h1>';
        html += '\t\t<h4 id="' + editor.TargetId + '_HeaderFormat4" class="header_format" data="h4">H4: ' + rangeText + '</h1>';
        html += '\t\t<h5 id="' + editor.TargetId + '_HeaderFormat5" class="header_format" data="h5">H5: ' + rangeText + '</h1>';
        html += '\t\t<h6 id="' + editor.TargetId + '_HeaderFormat6" class="header_format" data="h6">H6: ' + rangeText + '</h1>';
        html += '\t</div>';
        html += '</div>';

        editor.buildMaskPanel(html);

        for (var h = 1; h <= 6; h++) {
            var hfId = editor.TargetId + '_HeaderFormat' + h;
            var hfObj = STEditor.getObject(hfId);
            STEditor.attachEvent(hfObj, "click", function (event) {
                var hf = event.target || window.event.srcElement;
                var hValue = hf.getAttribute("data");
                STEditor.Plugins['h']['Callback'](editor, hValue);
            });
        }
    },
    "Callback": function (editor, commandParameters) {
        editor.closeMaskPanel();
        editor.reselectRange();
        var text = editor.htmlEncode(editor.RangeText);
        editor.insertHTML('<' + commandParameters + '>' + text + '</' + commandParameters + '>');
    },
    "UBBToXHTML": function (input, editor) {
        var batchReplacement = [
            [/\[h1\]([^\[]*?)\[\/h1\]/igm, '<h1>$1</h1>', true],
            [/\[h2\]([^\[]*?)\[\/h2\]/igm, '<h2>$1</h2>', true],
            [/\[h3\]([^\[]*?)\[\/h3\]/igm, '<h3>$1</h3>', true],
            [/\[h4\]([^\[]*?)\[\/h4\]/igm, '<h4>$1</h4>', true],
            [/\[h5\]([^\[]*?)\[\/h5\]/igm, '<h5>$1</h5>', true],
            [/\[h6\]([^\[]*?)\[\/h6\]/igm, '<h6>$1</h6>', true]
        ]; // [ubb pattern, html replacement, has embed tags]

        return batchReplacement;
    },
    "XHTMLToUBB": function (input, editor) {
        var batchReplacement = [
            [/<h1>([^<]*?)<\/h1>/igm, '[h1]$1[/h1]', true],
            [/<h2>([^<]*?)<\/h2>/igm, '[h2]$1[/h2]', true],
            [/<h3>([^<]*?)<\/h3>/igm, '[h3]$1[/h3]', true],
            [/<h4>([^<]*?)<\/h4>/igm, '[h4]$1[/h4]', true],
            [/<h5>([^<]*?)<\/h5>/igm, '[h5]$1[/h5]', true],
            [/<h6>([^<]*?)<\/h6>/igm, '[h6]$1[/h6]', true]
        ];  // [html pattern, ubb replacement, has embed tags]

        return batchReplacement;
    }
};