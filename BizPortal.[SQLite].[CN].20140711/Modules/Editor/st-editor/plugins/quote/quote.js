//quote plugin
STEditor.Plugins["quote"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/quote/';

        editor.loadSelection();
        var text = editor.htmlEncode(editor.RangeText);
        editor.insertHTML('<div class="ubb_quote_container">' + text + '</div>');
    },
    "Callback": function (editor) {

    },
    "UBBToXHTML": function (input, editor) {
        var batchReplacement = [
            [/\[quote\]([^\[]*?)\[\/quote\]/igm, '<div class="ubb_quote_container">$1</div>', true]
        ]; // [ubb pattern, html replacement, has embed tags]

        return batchReplacement;
    },
    "XHTMLToUBB": function (input, editor) {
        var batchReplacement = [
            [/<div[^>]*?class\s*=\s*"?ubb_quote_container"?[^>]*?>([^<]*?)<\/div>/igm, function ($0, $1) {
                var str = $1;
                str = '[quote]' + str + '[/quote]';
                return str;
            }, true]
        ];  // [html pattern, ubb replacement, has embed tags]

        return batchReplacement;
    }
};