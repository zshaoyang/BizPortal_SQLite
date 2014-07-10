//smiley picker plugin
STEditor.Plugins["smiley"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/smiley/';
        var cssUrl = pluginBaseUrl + 'themes/' + editor.Skin + '/skin.css'
        STEditor.importStyleSheet(cssUrl);

        var ni = 0;
        var rowNum = 6;
        var html = '<table cellpadding="0" cellspacing="5" class="STEditorSmileyTable">\n';
        html += '\t<tr>\n';
        html += '\t\t<td colspan="' + rowNum + '" class="title">' + editor.getLang("SmileyPicker") + editor.getLang("Colon") + '</td>\n';
        html += '\t</tr>\n';
        html += '\t<tr>\n';
        for (var ti = 0; ti < 24; ti++) {
            ni += 1;

            var imgBtnId = editor.TargetId + "_SmileyPickerBtn_" + ti;
            html += '\t\t<td><img id="' + imgBtnId + '" src="' + editor.BaseUrl + 'images/emotion/' + ni + '.gif" alt="' + ni + '" title="' + ni + '" /></td>\n';
            if (ni % rowNum == 0 && ni != 25) {
                html += '\t</tr>\n';
                html += '\t<tr>\n';
            };
        };
        html += '\t</tr>\n';
        html += '</table>';
        editor.buildMaskPanel(html);

        for (var ti = 0; ti < 24; ti++) {
            var imgBtnId = editor.TargetId + "_SmileyPickerBtn_" + ti;
            var imgBtn = STEditor.getObject(imgBtnId);
            STEditor.attachEvent(imgBtn, "click", function (event) {
                var evenImg = event.target || window.event.srcElement;
                STEditor.Plugins["smiley"]["Callback"](editor, evenImg.src);
            });
        }
    },
    "Callback": function (editor, commandParameters) {
        editor.closeMaskPanel();
        editor.executeEditorCommand('insertimage', commandParameters);
    }
};