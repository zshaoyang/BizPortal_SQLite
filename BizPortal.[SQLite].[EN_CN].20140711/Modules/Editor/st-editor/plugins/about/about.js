//about plugin
STEditor.Plugins["about"] = {
    "Execute": function (editor) {
        var pluginBaseUrl = editor.BaseUrl + 'plugins/about/';
        var cssUrl = pluginBaseUrl + 'themes/' + editor.Skin + '/skin.css'
        STEditor.importStyleSheet(cssUrl);

        var btnId = editor.TargetId + "_AboutBoxOkButton";
        var html = '<table cellpadding="0" cellspacing="5" class="STEditorAboutBox">\n';
        html += '\t<tr>\n';
        html += '\t\t<td class="title">' + editor.getLang("About") + editor.getLang("Colon") + '</td>\n';
        html += '\t</tr>\n';
        html += '\t<tr>\n';
        html += '\t\t<td height="20"></td>\n';
        html += '\t</tr>\n';
        html += '\t<tr>\n';
        html += '\t\t<td><span>' + STEditor.AppInfo.Name + ', Version: ' + STEditor.AppInfo.Edition + STEditor.AppInfo.Version + ' (' + STEditor.AppInfo.Build + ')' + '</span></td>\n';
        html += '\t</tr>\n';
        html += '\t<tr>\n';
        html += '\t\t<td><span><a href="' + STEditor.AppInfo.WebSite + '" target="_blank" title="' + STEditor.AppInfo.Author + '">&copy;' + STEditor.AppInfo.Copyright + '</a></span></td>\n';
        html += '\t</tr>\n';
        html += '\t<tr>\n';
        html += '\t\t<td height="20"></td>\n';
        html += '\t</tr>\n';
        html += '\t<tr>\n';
        html += '\t\t<td class="item"><input id="' + btnId + '" type="button" value="' + editor.getLang("OK") + '" class="btn" /></td>\n';
        html += '\t</tr>\n';
        html += '</table>';
        editor.buildMaskPanel(html);

        var btn = STEditor.getObject(btnId);
        STEditor.attachEvent(btn, "click", function (event) {
            editor.closeMaskPanel();
        });
    },
    "Callback": function (editor) {

    }
};