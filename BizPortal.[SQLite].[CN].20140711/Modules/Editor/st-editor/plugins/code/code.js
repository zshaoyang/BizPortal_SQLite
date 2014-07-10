//code plugin
STEditor.Plugins["code"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/code/';

        editor.loadSelection();
        var text = editor.htmlEncode(editor.RangeText);
        editor.insertHTML('<div class="ubb_code_container">' + text + '</div>');
    },
    "Callback": function (editor) {

    },
    "UBBToXHTML": function (input, editor) {
        var batchReplacement = [
            [/\[code\]([^\[]*?)\[\/code\]/igm, '<div class="ubb_code_container">$1</div>', true]
        ]; // [ubb pattern, html replacement, has embed tags]

        return batchReplacement;
    },
    "XHTMLToUBB": function (input, editor) {
        var batchReplacement = [
            [/<div[^>]*?class\s*=\s*"?ubb_code_container"?[^>]*?>([^<]*?)<\/div>/igm, function ($0, $1) {
                var str = $1;
                str = '[code]' + str + '[/code]';
                return str;
            }, true]
        ];  // [html pattern, ubb replacement, has embed tags]

        return batchReplacement;
    }
};