/*******************************************************************************
* ST-Editor - SleepingTiger-Editor - WYSIWYG UBB-HTML Editor for Internet
* Copyright (C) 2013 1986z.com
*
* @author Iron <zshaoyang@gmail.com>
* @website http://www.1986z.net/
* @version Beta 1.0 (2013-10-18)
*******************************************************************************/
/*
Description: online UBB WYSIWYG Editor
@param string targetId: id of the textarea to replace, necessary
@param json options: customize configs, optional
* */
function STEditor(targetId, options) {
    var self = this;
    if (!STEditor.isset(window.STEditor)) {
        return;
    }
    if (typeof (STEditor.Instances[targetId]) != 'undefined') {
        return;
    }

    self.TargetId = targetId;

    self.loadOptions(options);

    self.init();

    STEditor.Instances[targetId] = self;
}

STEditor.AppInfo = {
    "Name": "SleepingTiger.STEditor",
    "Version": "1.0",
    "Edition": "Beta",
    "Build": "20131018",
    "Author": "Iron",
    "Copyright": "2013 1986z.com",
    "WebSite": "http://www.1986z.com/"
};

STEditor.LoadedFiles = []; //save file path of script or css files already imported
STEditor.Lang = {}; //language dictionary
STEditor.Plugins = {}; //plugins dictionary

//toolbar configs
STEditor.ToolbarConfigs = {
    "All": [
        'b', 'i', 'u', 's', 'remove_format', '-', 'link', 'unlink', 'img', 'fl', '-', 'code', 'quote', 'anchor', '-', 'left', 'center', 'right', 'full', '-', 'ol', 'ul', 'fscreen',
        '|', 'h', 'font', 'size', 'fore_color', 'bg_color', '-', 'sub', 'sup', 'hr', 'smiley', '-', 'source', 'about'
    ],
    "Basic": [
        'source', '-', 'b', 'i', 'u', 's', 'remove_format', '-', 'link', 'unlink', 'img', 'fore_color', 'bg_color', '-', 'fscreen', 'about'
    ],
    "Mini": [
        'source', '-', 'b', 'i', 'u', 's', '-', 'link', 'unlink', '-', 'about'
    ]
};

STEditor.Instances = {}; //all editor instances container
//get editor instance of editorId (textarea id)
STEditor.get = function (editorId) {
    return STEditor.Instances[editorId];
};
//
STEditor.create = function (editorId, options) {
    var editor = new STEditor(editorId, options);
};

//get object of id
STEditor.getObject = function (objId) {
    return document.getElementById(objId);
};
//get iframe object of id
STEditor.getIFrameWindow = function (ifmId) {
    var obj = null;
    try {
        obj = document.frames[ifmId];
    }
    catch (ex) {
        //
    }
    if (obj == null) {
        try {
            obj = STEditor.getObject(ifmId).contentWindow;
        }
        catch (ex) {
            //
        }
    };
    return obj;
}
//attach event to object
STEditor.attachEvent = function (obj, action, handler) {
    if (window.attachEvent) {
        obj.attachEvent('on' + action, function (event) {
            handler.call(obj, event);
        });
    }
    else {
        obj.addEventListener(action, function (event) {
            handler(event);
        }, false);
    }
};
//check the var is defined
STEditor.isset = function (varObj) {
    return typeof (varObj) != 'undefined';
};
//get the value's index in arrary
STEditor.inArray = function (val, arr) {
    for (var i = 0, len = arr.length; i < len; i++) {
        if (val === arr[i]) {
            return i;
        }
    }
    return -1;
};
//get the directory path of current javascript file
STEditor.getBaseUrl = function () {
    var scripts = document.getElementsByTagName("script");
    if (typeof (scripts) == 'object' && scripts.length > 0) {
        for (var i = 0; i < scripts.length; i++) {
            var sc = scripts[i];
            if (!sc.src) {
                continue;
            }
            var onlySrc = sc.src;
            if (onlySrc.indexOf("?") > 0) {
                onlySrc = onlySrc.substring(0, onlySrc.indexOf("?"));
            }
            if (onlySrc.indexOf("st-editor") > -1) {
                var baseUrl = onlySrc.substring(0, onlySrc.lastIndexOf("/") + 1);
                return baseUrl;
                break;
            }
        }
    }
    return "/";
};
//get ie browser's version
STEditor.getIEVersion = function () {
    var version = -1;
    var agent = navigator.userAgent.toLowerCase();
    var isIE = agent.indexOf('msie') != -1 && document.all;
    if (isIE) {
        version = agent.substr(agent.indexOf('msie'));
        version = version.substr(0, version.indexOf('.'));
        version = version.replace('msie', '');
        version = parseInt(version);
    }
    return version;
};
//import script file
STEditor.importScript = function (importSrc) {
    var hasImport = STEditor.inArray(importSrc, STEditor.LoadedFiles) > -1;

    if (!hasImport) {
        var head = document.getElementsByTagName('head').item(0);
        if (!head) {
            head = document.getElementsByTagName('body').item(0);
        }
        if (head) {
            var impScript = document.createElement('script');
            impScript.setAttribute('type', 'text/javascript');
            impScript.setAttribute('src', importSrc);
            head.appendChild(impScript);
        }
    }
};
//import css file
STEditor.importStyleSheet = function (linkHref) {
    var hasImport = STEditor.inArray(linkHref, STEditor.LoadedFiles) > -1;

    if (hasImport == false) {
        var head = document.getElementsByTagName('head').item(0);
        if (!head) {
            head = document.getElementsByTagName('body').item(0);
        }
        if (head) {
            var cssLink = document.createElement('link');
            cssLink.setAttribute('rel', 'stylesheet');
            cssLink.setAttribute('type', 'text/css');
            cssLink.setAttribute('href', linkHref);
            head.appendChild(cssLink);
        }
    }
};


//id of the textarea to replace
STEditor.prototype.TargetId = null;
//directory path of current javascript file
STEditor.prototype.BaseUrl = '';
//edit state - 1:visual,0:UBB source
STEditor.prototype.EditMode = 1;
//UBB mode - 1:default textarea value is ubb, 0:default textarea value is html
STEditor.prototype.UBBMode = 0;
//save value type - 0:ubb, 1:html
STEditor.prototype.SaveMode = 0;
//full screen mode 1:yes, 0:no
STEditor.prototype.FullScreen = 0;

//current skin directory name
STEditor.prototype.Skin = 'default';
//current language
STEditor.prototype.Lang = 'en';
//editor's width and height (px)
STEditor.prototype.Size = { "Width": null, "Height": null };
STEditor.prototype.Offset = { "Position": null, "Top": null, "Left": null, "ZIndex": null };
//editor's toolbar item array
STEditor.prototype.Toolbar = null;

//a input[hidden] form item to store final ubb content
STEditor.prototype.FormInput = null;
//contentWindow object of editor iframe
STEditor.prototype.EditorWindow = null;

//document selection
STEditor.prototype.Selection = null;
STEditor.prototype.Range = null;
STEditor.prototype.RangeText = null;

//
STEditor.prototype.getTagObject = function (str, tag) {
    var self = this;
    var obj = null;
    if (str && tag) {
        var factoryBox = STEditor.getObject(self.TargetId + '_EditorFactory');
        factoryBox.innerHTML = str;
        obj = factoryBox.getElementsByTagName(tag).item(0);
    }
    return obj;
};
//get language
STEditor.prototype.getLang = function (key) {
    var self = this;
    return STEditor.Lang[self.Lang][key];
};
//convert RGB color value to Hex value
STEditor.prototype.convertRGBToHex = function (str) {
    var sRGB2HexValue = '';
    var regExp = /([0-9]+)[, ]+([0-9]+)[, ]+([0-9]+)/;
    var oArray = regExp.exec(str);
    if (!oArray) {
        sRGB2HexValue = str;
    }
    else {
        for (var i = 1; i < oArray.length; i++) {
            sRGB2HexValue += ('0' + parseInt(oArray[i]).toString(16)).slice(-2);
        }
        sRGB2HexValue = '#' + sRGB2HexValue;
    };
    return sRGB2HexValue;
};
//HTML encode
STEditor.prototype.htmlEncode = function (str) {
    if (str) {
        str = str.replace(/&/igm, '&amp;');
        str = str.replace(/</igm, '&lt;');
        str = str.replace(/>/igm, '&gt;');
        str = str.replace(/\"/igm, '&quot;');
        str = str.replace(/ /igm, '&nbsp;');
    }
    return str;
};
//HTML decode
STEditor.prototype.htmlDecode = function (str) {
    if (str) {
        str = str.replace(/&lt;/igm, '<');
        str = str.replace(/&gt;/igm, '>');
        str = str.replace(/&quot;/igm, '"');
        str = str.replace(/&nbsp;/igm, ' ');
        str = str.replace(/&amp;/igm, '&');
    }
    return str;
};
//replace many things...
STEditor.prototype.batchReplace = function (str, arr) {
    var s = true;
    for (var i = 0; i < arr.length; i++) {
        if (!arr[i][2]) {
            str = str.replace(arr[i][0], arr[i][1]);
        }
    }
    while (s) { //this loop to resolve embed tags
        s = false;
        for (var i = 0; i < arr.length; i++) {
            if (arr[i][2] && str.search(arr[i][0]) != -1) {
                s = true;
                str = str.replace(arr[i][0], arr[i][1]);
            }
        }
    }
    return str;
};
//convert HTML to standard XHTML
STEditor.prototype.convertHTMLToXHTML = function (str) {
    if (str) {
        str = str.replace(/<br.*?>/ig, '<br />');
        str = str.replace(/(<hr[^>]*)>/ig, '$1 />');
        str = str.replace(/(<img[^>]*)>/ig, '$1 />');
    }
    return str;
};
//clear all HTML tags
STEditor.prototype.removeHtml = function (str) {
    if (str) {
        str = str.replace(/<script[^>]*>[\s\S]*?<\/script[^>]*>/gim, '');
        str = str.replace(/<(\/?)(script|i?frame|style|html|head|body|title|link|meta|object|\?|\%)([^>]*?)>/gi, '');
        str = str.replace(/<([a-z]+)+\s*(?:onerror|onload|onunload|onresize|onblur|onchange|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup|onmousemove|onmousedown|onmouseout|onmouseover|onmouseup|onselect)[^>]*>/gi, '<$1>');
    }
    return str;
};
//convert HTML to UBB
STEditor.prototype.convertXHTMLToUBB = function (input) {
    if (input) {
        var self = this;
        var batchReplaceAry = [ // [html pattern, ubb replacement, has embed tags]
          [/<br \/>/ig, '[br]', false],
          [/<hr[^>]*?\/>/ig, '[hr]', false],
          [/<p>([^<]*?)<\/p>/igm, '[p]$1[/p]', true],
          [/<b>([^<]*?)<\/b>/igm, '[b]$1[/b]', true],
          [/<s>([^<]*?)<\/s>/igm, '[s]$1[/s]', true],
          [/<strong>([^<]*?)<\/strong>/igm, '[b]$1[/b]', true],
          [/<i>([^<]*?)<\/i>/igm, '[i]$1[/i]', true],
          [/<em>([^<]*?)<\/em>/igm, '[i]$1[/i]', true],
          [/<u>([^<]*?)<\/u>/igm, '[u]$1[/u]', true],
          [/<ol>([^<]*?)<\/ol>/igm, '[ol]$1[/ol]', true],
          [/<ul>([^<]*?)<\/ul>/igm, '[ul]$1[/ul]', true],
          [/<li>([^<]*?)<\/li>/igm, '[li]$1[/li]', true],
          [/<sub>([^<]*?)<\/sub>/igm, '[sub]$1[/sub]', true],
          [/<sup>([^<]*?)<\/sup>/igm, '[sup]$1[/sup]', true],
          [/<a[^<]*?class="post_anchor"[^>]*?>[^>]*?<\/a>/igm, function ($0) {
              var obj = self.getTagObject($0, 'a');
              var anchorId = '';
              if (obj.id) {
                  anchorId = obj.id;
              }
              if (obj.getAttribute('id')) {
                  anchorId = obj.getAttribute('id');
              }
              if (anchorId != '') {
                  return '[anchor]' + anchorId + '[/anchor]';
              }
              return '';
          }, true],

          [/<span[^>]*style="color:([^>;]+);?"[^>]*>([^<]*?)<\/span>/igm, '[color=$1]$2[/color]', true],
          [/<span[^>]*style="background-color:([^>;]+);?"[^>]*>([^<]*?)<\/span>/igm, '[bgcolor=$1]$2[/bgcolor]', true],
          [/<span[^>]*style="font-weight:bold;?"[^>]*>([^<]*?)<\/span>/igm, '[b]$1[/b]', true],
          [/<span[^>]*style="font-style:italic;?"[^>]*>([^<]*?)<\/span>/igm, '[i]$1[/i]', true],
          [/<span[^>]*style="text-decoration:underline;?"[^>]*>([^<]*?)<\/span>/igm, '[u]$1[/u]', true],
          [/<span[^>]*style="text-decoration:line-through;?"[^>]*>([^<]*?)<\/span>/igm, '[s]$1[/s]', true],

          [/<font\s[^>]*?>([^<]*?)<\/font>/igm, function ($0, $1) {
              var str = $1;
              var obj = self.getTagObject($0, 'font');
              if (obj.getAttribute('color')) {
                  str = '[color=' + self.convertRGBToHex(obj.getAttribute('color')) + ']' + str + '[/color]';
              }
              if (obj.style.color) {
                  str = '[color=' + self.convertRGBToHex(obj.style.color) + ']' + str + '[/color]';
              }
              if (obj.style.backgroundColor) {
                  str = '[bgcolor=' + self.convertRGBToHex(obj.style.backgroundColor) + ']' + str + '[/bgcolor]';
              }
              return str;
          }, true],

          [/<p[^>]*style="color:([^>;]+);?"[^>]*>([^<]*?)<\/p>/igm, '[p][color=$1]$2[/color][/p]', true],
          [/<p[^>]*style="background-color:([^>;]+);?"[^>]*>([^<]*?)<\/p>/igm, '[p][bgcolor=$1]$2[/bgcolor][/p]', true],
          [/<p[^>]*style="font-weight:bold;?"[^>]*>([^<]*?)<\/p>/igm, '[p][b]$1[/b][/p]', true],
          [/<p[^>]*style="font-style:italic;?"[^>]*>([^<]*?)<\/p>/igm, '[p][i]$1[/i][/p]', true],
          [/<p[^>]*style="text-decoration:underline;?"[^>]*>([^<]*?)<\/p>/igm, '[p][u]$1[/u][/p]', true],
          [/<p[^>]*style="text-decoration:line-through;?"[^>]*>([^<]*?)<\/p>/igm, '[p][s]$1[/s][/p]', true],
          [/<p[^>]*?align="?(\w+)"?[^>]*?>([^<]*?)<\/p>/igm, '[align=$1]$2[/align]', true],
          [/<p[^>]*?style="text-align:(\w+);?"[^>]*?>([^<]*?)<\/p>/igm, '[align=$1]$2[/align]', true],

          [/<div[^>]*?align="?(\w+)"?[^>]*?>([^<]*?)<\/div>/igm, '[align=$1]$2[/align]', true],
          [/<div[^>]*?style="text-align:(\w+?);?"[^>]*?>([^<]*?)<\/div>/igm, '[align=$1]$2[/align]', true],

          [/<a[^>]*?href="([^>]+?);?"[^>]*?>([^<]*?)<\/a>/igm, '[url=$1]$2[/url]', true],

          [/<img[^>]*?src="([^>]+?);?"[^>]*?>/igm, '[img]$1[/img]', true],

          [/\]\[br\]\[/igm, '] [', true],
          [/\[br\]\[\/p\]/igm, '[/p]', true],
          [/\[\/p\]\[p\]/igm, '[/p]\r\n[p]', true]
        ];

        for (var pluginName in STEditor.Plugins) {
            var plugin = STEditor.Plugins[pluginName];
            if (STEditor.isset(plugin["XHTMLToUBB"])) {
                var pluginReplaceAry = plugin["XHTMLToUBB"](input, self);
                for (var pi = 0; pi < pluginReplaceAry.length; pi++) {
                    batchReplaceAry.push(pluginReplaceAry[pi]);
                }
            }
        }
        input = self.batchReplace(input, batchReplaceAry);

        input = input.replace(/<[^>]*>/igm, '');
    }
    return input;
};
//convert UBB to HTML
STEditor.prototype.convertUBBToXHTML = function (str) {
    if (str) {
        var self = this;
        var batchReplaceAry = [ // [ubb pattern, html replacement, has embed tags]
          [/\[br\]/igm, '<br />', false],
          [/\[hr\]/igm, '<hr />', false],
          [/\[p\]([^\[]*?)\[\/p\]/igm, '<p>$1</p>', true],
          [/\[b\]([^\[]*?)\[\/b\]/igm, '<b>$1</b>', true],
          [/\[i\]([^\[]*?)\[\/i\]/igm, '<i>$1</i>', true],
          [/\[u\]([^\[]*?)\[\/u\]/igm, '<u>$1</u>', true],
          [/\[s\]([^\[]*?)\[\/s\]/igm, '<span style="text-decoration:line-through;">$1</span>', true],
          [/\[ol\]([^\[]*?)\[\/ol\]/igm, '<ol>$1</ol>', true],
          [/\[ul\]([^\[]*?)\[\/ul\]/igm, '<ul>$1</ul>', true],
          [/\[li\]([^\[]*?)\[\/li\]/igm, '<li>$1</li>', true],
          [/\[sub\]([^\[]*?)\[\/sub\]/igm, '<sub>$1</sub>', true],
          [/\[sup\]([^\[]*?)\[\/sup\]/igm, '<sup>$1</sup>', true],
          [/\[color=([^\]]*)\]([^\[]*?)\[\/color\]/igm, '<span style="color:$1;">$2</span>', true],
          [/\[bgcolor=([^\]]*)\]([^\[]*?)\[\/bgcolor\]/igm, '<span style="background-color:$1;">$2</span>', true],
          [/\[align=([^\]]*)\]([^\[]*?)\[\/align\]/igm, '<div style="text-align:$1;" align="$1">$2</div>', true],
          [/\[url=([^\]]*)\]([^\[]*?)\[\/url\]/igm, '<a href="$1">$2</a>', true],
          [/\[img\]([^\[]*?)\[\/img\]/igm, '<img src="$1" class="post_img" />', true],
          [/\[anchor\]([^\[]*?)\[\/anchor\]/igm, '<a id="$1" class="post_anchor">&nbsp;</a>', true]
        ];

        for (var pluginName in STEditor.Plugins) {
            var plugin = STEditor.Plugins[pluginName];
            if (STEditor.isset(plugin["UBBToXHTML"])) {
                var pluginReplaceAry = plugin["UBBToXHTML"](str, self);

                for (var pi = 0; pi < pluginReplaceAry.length; pi++) {
                    batchReplaceAry.push(pluginReplaceAry[pi]);
                }
            }
        }

        str = self.batchReplace(str, batchReplaceAry);
    }
    return str;
};

//initialize and load options
STEditor.prototype.loadOptions = function (options) {
    var self = this;
    self.Size = { "Width": null, "Height": null };
    self.Offset = { "Position": null, "Top": null, "Left": null, "ZIndex": null };
    self.Skin = 'default';
    self.Lang = 'en';
    self.Toolbar = null;
    self.FormInput = null;
    self.UBBMode = 0;
    self.SaveMode = 0;

    if (STEditor.isset(options)) {
        if (STEditor.isset(options["Width"])) {
            self.Size.Width = parseInt(options["Width"]);
        }
        if (STEditor.isset(options["Height"])) {
            self.Size.Height = parseInt(options["Height"]);
        }
        if (STEditor.isset(options["Skin"])) {
            self.Skin = options["Skin"];
        }
        if (STEditor.isset(options["Lang"])) {
            self.Lang = options["Lang"];
        }
        if (STEditor.isset(options["ToolbarConfig"])) {
            self.Toolbar = STEditor.ToolbarConfigs[options["ToolbarConfig"]];
        }
        if (STEditor.isset(options["Toolbar"])) {
            self.Toolbar = options["Toolbar"];
        }
        if (STEditor.isset(options["UBBMode"])) {
            self.UBBMode = options["UBBMode"];
        }
        if (STEditor.isset(options["SaveMode"])) {
            self.SaveMode = options["SaveMode"];
        }
    }
};
//create css link tag
STEditor.prototype.buildStyleSheet = function () {
    var self = this;
    var linkHref = self.BaseUrl + 'themes/' + self.Skin + '/editor.css?v=' + STEditor.AppInfo.Build;
    STEditor.importStyleSheet(linkHref);
};
//create script tag of language
STEditor.prototype.buildLangScript = function () {
    var self = this;
    var langSrc = self.BaseUrl + 'lang/' + self.Lang + ".js?v=" + STEditor.AppInfo.Build;
    STEditor.importScript(langSrc);
};
//save final ubb content
STEditor.prototype.setFormInputValue = function () {
    var self = this;
    var html = self.getHTML();
    html = self.convertHTMLToXHTML(html);

    if (self.SaveMode == 0) {
        html = self.convertXHTMLToUBB(html);
        html = self.removeHtml(html);
    }

    self.FormInput.value = html;
};
//get HTML from editor contentWindow
STEditor.prototype.getHTML = function () {
    var self = this;
    var html = self.EditorWindow.document.body.innerHTML;
    return html;
};
//get ubb from editor
STEditor.prototype.getUBB = function () {
    var self = this;
    var html = self.getHTML();
    html = self.convertHTMLToXHTML(html);
    html = self.removeHtml(html);
    html = self.convertXHTMLToUBB(html);
    return html;
};
//document selection
STEditor.prototype.loadSelection = function () {
    var self = this;

    if (self.EditorWindow.getSelection) {
        self.Selection = self.EditorWindow.getSelection();
        self.Range = self.Selection.getRangeAt(0);
        self.RangeText = self.Range.toString();
    }
    else {
        self.Selection = self.EditorWindow.document.selection;
        self.Range = self.Selection.createRange();
        self.RangeText = self.Range.text;
    }
};
//Reselect range
STEditor.prototype.reselectRange = function () {
    var self = this;
    try {
        if (self.RangeText) {
            self.Range.select();
        }
        else {
            self.Range.focus();
        }
    }
    catch (ex) { }
};
//build mask panel
STEditor.prototype.createMask = function () {
    var self = this;
    var container = STEditor.getObject(self.TargetId + '_EditorContainer');
    if (container) {
        var mask = document.createElement('div');
        mask.setAttribute('id', self.TargetId + '_EditorMask');
        mask.style.position = 'absolute';
        mask.style.top = '-1px';
        mask.style.left = '-1px';
        mask.style.background = '#FFFFFF';
        mask.style.filter = 'Alpha(Opacity=60)';
        mask.style.opacity = '0.6';
        mask.style.width = container.offsetWidth + 'px';
        mask.style.height = container.offsetHeight + 'px';
        mask.style.zIndex = '100';
        container.appendChild(mask);
        var maskPanel = document.createElement('div');
        maskPanel.setAttribute('id', self.TargetId + '_EditorMaskPanel');
        maskPanel.style.position = 'absolute';
        maskPanel.style.top = '35%';
        maskPanel.style.left = '35%';
        maskPanel.style.zIndex = '101';
        maskPanel.className = "STEditorMaskPanel";
        container.appendChild(maskPanel);
    }
};
//build mask panel
STEditor.prototype.buildMaskPanel = function (html) {
    if (html) {
        var self = this;
        var maskPanelId = self.TargetId + '_EditorMaskPanel';
        var maskPanelCloseId = self.TargetId + '_EditorMaskPanelCloser';
        var maskPanel = STEditor.getObject(maskPanelId);
        if (!maskPanel) {
            self.createMask();
            maskPanel = STEditor.getObject(maskPanelId);
        };
        if (maskPanel) {
            var maskPanelInnerHTML = '<div class="STEditorMaskPanelInner">';
            maskPanelInnerHTML += html;
            maskPanelInnerHTML += '<div id="' + maskPanelCloseId + '" class="STEditorMaskPanelCloser"><img src="' + self.BaseUrl + 'themes/' + self.Skin + '/images/close.gif" /></div>';
            maskPanelInnerHTML += '</div>';
            maskPanel.style.display = 'none';
            maskPanel.innerHTML = maskPanelInnerHTML;
            maskPanel.style.display = 'block';
            maskPanel.style.marginLeft = (0 - Math.floor(maskPanel.offsetWidth / 2)) + 'px';
            maskPanel.style.marginTop = (0 - Math.floor(maskPanel.offsetHeight / 2) + 14) + 'px';

            var maskPanelCloser = STEditor.getObject(maskPanelCloseId);
            STEditor.attachEvent(maskPanelCloser, "click", function (event) {
                self.closeMaskPanel();
            });
        }
    }
};
//remove mask panel
STEditor.prototype.closeMaskPanel = function () {
    var self = this;
    var container = STEditor.getObject(self.TargetId + '_EditorContainer');
    if (container) {
        var mask = STEditor.getObject(self.TargetId + '_EditorMask');
        var maskPanel = STEditor.getObject(self.TargetId + '_EditorMaskPanel');
        if (mask && maskPanel) {
            container.removeChild(mask);
            container.removeChild(maskPanel);
        };
    };
};
//build color picker table
STEditor.prototype.buildColorTable = function (type, callbackCommand) {
    var self = this;
    var ni = 0;
    var rowNum = 8;
    var colorHexAry = new Array('00', '88', 'CC', 'FF');
    var colorHexAryLength = colorHexAry.length;
    var html = '<table cellpadding="0" cellspacing="5" class="STEditorColorPickerTable">\n';
    html += '\t<tr>\n';
    html += '\t\t<td colspan="' + rowNum + '">' + self.getLang("ColorPicker") + '</td>\n';
    html += '\t</tr>\n';
    html += '\t<tr>\n';
    for (var ti = 0; ti < colorHexAryLength; ti++) {
        for (var tj = 0; tj < colorHexAryLength; tj++) {
            for (var tk = 0; tk < colorHexAryLength; tk++) {
                ni += 1;

                var colorValueStr = '' + colorHexAry[ti] + colorHexAry[tj] + colorHexAry[tk] + '';

                var imgBtnId = self.TargetId + "_" + type + "_PickerBtn_" + colorValueStr;
                html += '\t\t<td><img id="' + imgBtnId + '" src="' + self.BaseUrl + 'themes/' + self.Skin + '/images/space.gif" style="background: #' + colorValueStr + ';" data="' + colorValueStr + '" alt="' + colorValueStr + '" title="' + colorValueStr + '" /></td>\n';
                if (ni % rowNum == 0 && ni != (colorHexAryLength * colorHexAryLength * colorHexAryLength)) {
                    html += '\t</tr>\n';
                    html += '\t<tr>\n';
                }
            }
        }
    }
    html += '\t\t</tr>\n';
    html += '</table>';
    self.buildMaskPanel(html);

    for (var ti = 0; ti < colorHexAryLength; ti++) {
        for (var tj = 0; tj < colorHexAryLength; tj++) {
            for (var tk = 0; tk < colorHexAryLength; tk++) {
                var colorValueStr = '' + colorHexAry[ti] + colorHexAry[tj] + colorHexAry[tk] + '';

                var imgBtnId = self.TargetId + "_" + type + "_PickerBtn_" + colorValueStr;
                var imgBtn = STEditor.getObject(imgBtnId);
                STEditor.attachEvent(imgBtn, "click", function (event) {
                    var eventBtn = event.target || window.event.srcElement;
                    var data = eventBtn.getAttribute("data");
                    self.executeToolbarItem(callbackCommand, '#' + data);
                });
            }
        }
    }
};
//build fore color picker table
STEditor.prototype.buildForeColorTable = function () {
    var self = this;
    self.buildColorTable("ForeColor", 'fore_color_callback');
};
//build back color picker table
STEditor.prototype.buildBackColorTable = function () {
    var self = this;
    self.buildColorTable("BackColor", 'bg_color_callback');
};

//build a one input table
STEditor.prototype.buildCommonInputTable = function (command, title, defaultValue, callbackCommand) {
    var self = this;

    var inputId = self.TargetId + "_EditorText_" + command;
    var okBtnId = self.TargetId + "_EditorOkBtn_" + command;
    var cancelBtnId = self.TargetId + "_EditorCancelBtn_" + command;

    var html = '<div class="STEditor_Common_Table">\n';
    html += '\t<div class="title">' + title + self.getLang("Colon") + '</div>\n';
    html += '\t<div class="item"><input id="' + inputId + '" type="text" value="' + defaultValue + '" class="text" ondblclick="this.select();" /></div>\n';
    html += '\t<div class="tool"><input id="' + okBtnId + '" type="button" value="' + self.getLang("OK") + '" class="btn" />&nbsp;<input id="' + cancelBtnId + '" type="button" value="' + self.getLang("Cancel") + '" class="btn" /></div>\n';
    html += '</div>';
    self.buildMaskPanel(html);

    var input = STEditor.getObject(inputId);
    var okBtn = STEditor.getObject(okBtnId);
    var cancelBtn = STEditor.getObject(cancelBtnId);

    STEditor.attachEvent(okBtn, "click", function (event) {
        self.executeToolbarItem(callbackCommand, input.value);
    });

    STEditor.attachEvent(cancelBtn, "click", function (event) {
        self.closeMaskPanel();
    });
};
//build anchor creator table
STEditor.prototype.buildAnchorTable = function () {
    var self = this;

    self.buildCommonInputTable('anchor', self.getLang("AnchorName"), '', 'anchor_callback');
};
//build super link creator table
STEditor.prototype.buildLinkTable = function () {
    var self = this;

    self.buildCommonInputTable('link', self.getLang("LinkURL"), 'http://', 'link_callback');
};
//build image creator table
STEditor.prototype.buildImageTable = function () {
    var self = this;

    self.buildCommonInputTable('img', self.getLang("ImageURL"), 'http://', 'img_callback');
};

//switch to full screen mode
STEditor.prototype.switchToFullScreen = function () {
    var self = this;
    var container = STEditor.getObject(self.TargetId + '_EditorContainer');
    var toolbar = STEditor.getObject(self.TargetId + '_ToolbarPanel');

    var fullWidth = window.screen.availWidth - 15;
    var fullHeight = window.screen.availHeight - 180;

    document.body.style.width = fullWidth + 'px';
    document.body.style.height = fullHeight + 'px';
    document.body.style.overflow = 'hidden';

    container.style.position = 'absolute';
    container.style.zIndex = 9999999;
    container.style.width = fullWidth + 'px';
    container.style.height = fullHeight + 'px';
    container.style.top = 0;
    container.style.left = 0;

    var sourceText = STEditor.getObject(self.TargetId + '_SourceBox');
    sourceText.style.width = (fullWidth - 10) + 'px';
    sourceText.style.maxWidth = (fullWidth - 10) + 'px';
    sourceText.style.height = (fullHeight - toolbar.offsetHeight - 15) + 'px';
    sourceText.style.maxHeight = (fullHeight - toolbar.offsetHeight - 15) + 'px';

    var editorArea = STEditor.getObject(self.TargetId + '_EditorArea');
    editorArea.style.width = fullWidth + 'px';
    var editorAreaHeight = fullHeight - toolbar.offsetHeight;
    editorArea.style.height = editorAreaHeight + 'px';

    var commandImg = STEditor.getObject(self.getToolbarItemLinkId("fscreen"));
    commandImg.className = 'toolbar_item_active';

    window.scrollTo(0, 0);

    self.FullScreen = 1;
};
//switch to normal screen mode
STEditor.prototype.switchToNormalScreen = function () {
    var self = this;
    var container = STEditor.getObject(self.TargetId + '_EditorContainer');
    var toolbar = STEditor.getObject(self.TargetId + '_ToolbarPanel');

    document.body.style.width = '';
    document.body.style.height = '';
    document.body.style.overflow = '';

    container.style.position = self.Offset.Position;
    container.style.zIndex = self.Offset.ZIndex;
    container.style.width = (self.Size.Width) + 'px';
    container.style.height = (self.Size.Height) + 'px';
    container.style.top = self.Offset.Top;
    container.style.left = self.Offset.Left;

    var sourceText = STEditor.getObject(self.TargetId + '_SourceBox');
    sourceText.style.width = (self.Size.Width - 10) + 'px';
    sourceText.style.maxWidth = (self.Size.Width - 10) + 'px';
    sourceText.style.height = (self.Size.Height - toolbar.offsetHeight - 15) + 'px';
    sourceText.style.maxHeight = (self.Size.Height - toolbar.offsetHeight - 15) + 'px';

    var editorArea = STEditor.getObject(self.TargetId + '_EditorArea');
    editorArea.style.width = self.Size.Width + 'px';
    var editorAreaHeight = self.Size.Height - toolbar.offsetHeight;
    editorArea.style.height = editorAreaHeight + 'px';

    var commandImg = STEditor.getObject(self.getToolbarItemLinkId("fscreen"));
    commandImg.className = 'toolbar_item';

    window.scrollTo(container.offsetLeft, container.offsetTop);

    self.FullScreen = 0;
};

//switch to ubb source mode
STEditor.prototype.switchSourceMode = function () {
    var self = this;
    if (self.EditMode == 1) {
        var sourceImg;
        var html = self.getHTML();

        self.EditMode = 0;
        html = self.convertHTMLToXHTML(html);
        html = self.convertXHTMLToUBB(html);
        html = self.removeHtml(html);

        sourceImg = STEditor.getObject(self.getToolbarItemLinkId("source"));
        sourceImg.className = 'toolbar_item_active';

        var sourceTextBox = STEditor.getObject(self.TargetId + '_SourceBox');
        sourceTextBox.style.display = '';
        sourceTextBox.value = html;
        var editorArea = STEditor.getObject(self.TargetId + '_EditorArea');
        editorArea.style.display = 'none';
    }
};
//switch to normal mode
STEditor.prototype.switchNormalMode = function () {
    var self = this;
    if (self.EditMode == 0) {
        var sourceImg;
        var sourceTextBox = STEditor.getObject(self.TargetId + '_SourceBox');
        var sValue = sourceTextBox.value;
        self.EditMode = 1;
        sValue = self.convertUBBToXHTML(sValue);

        sourceImg = STEditor.getObject(self.getToolbarItemLinkId("source"));
        sourceImg.className = 'toolbar_item';
        sourceTextBox.style.display = 'none';
        var editorArea = STEditor.getObject(self.TargetId + '_EditorArea');
        editorArea.style.display = '';
        self.EditorWindow.document.body.innerHTML = sValue;
    }
};

//click toolbar button
STEditor.prototype.executeToolbarItem = function (command, commandParameters) {
    var self = this;
    if (self.EditMode == 1) {
        switch (command) {
            case 'anchor':
                self.buildAnchorTable();
                self.loadSelection();
                break;
            case 'anchor_callback':
                self.closeMaskPanel();
                self.reselectRange();
                self.insertHTML(self.RangeText + '<a id="' + commandParameters + '" class="post_anchor">&nbsp;</a>');
                break;

            case 'b':
                self.executeEditorCommand('bold');
                break;

            case 'bg_color':
                self.buildBackColorTable();
                break;
            case 'bg_color_callback':
                self.closeMaskPanel();
                try {
                    self.executeEditorCommand('bgcolor', commandParameters);
                }
                catch (ex) {
                    self.executeEditorCommand('backcolor', commandParameters);
                };
                break;

            case 'center':
                self.executeEditorCommand('justifycenter');
                break;

            case 'fore_color':
                self.buildForeColorTable();
                break;
            case 'fore_color_callback':
                self.closeMaskPanel();
                self.executeEditorCommand('forecolor', commandParameters);
                break;

            case 'full':
                self.executeEditorCommand('justifyfull');
                break;

            case 'fscreen':
                if (self.FullScreen == 1) {
                    self.switchToNormalScreen();
                }
                else {
                    self.switchToFullScreen();
                }
                break;

            case 'hr':
                self.executeEditorCommand('InsertHorizontalRule');
                break;

            case 'i':
                self.executeEditorCommand('italic');
                break;

            case 'img':
                self.buildImageTable();
                self.loadSelection();
                break;
            case 'img_callback':
                self.closeMaskPanel();
                self.reselectRange();
                self.executeEditorCommand('insertimage', commandParameters);
                break;

            case 'left':
                self.executeEditorCommand('justifyleft');
                break;

            case 'link':
                self.buildLinkTable();
                self.loadSelection();
                break;
            case 'link_callback':
                self.closeMaskPanel();
                self.reselectRange();
                self.executeEditorCommand('createlink', commandParameters);
                break;

            case 'ol':
                self.executeEditorCommand('insertorderedlist');
                break;

            case 'right':
                self.executeEditorCommand('justifyright');
                break;

            case 'remove_format':
                self.executeEditorCommand('removeformat');
                break;

            case 's':
                self.loadSelection();
                var strikeText = self.htmlEncode(self.RangeText);
                self.insertHTML('<span style="text-decoration:line-through;">' + strikeText + '</span>');
                break;

            case 'source':
                self.switchSourceMode();
                break;

            case 'sub':
                self.loadSelection();
                var subText = self.htmlEncode(self.RangeText);
                self.insertHTML('<sub>' + subText + '</sub>');
                break;
            case 'sup':
                self.loadSelection();
                var supText = self.htmlEncode(self.RangeText);
                self.insertHTML('<sup>' + supText + '</sup>');
                break;

            case 'u':
                self.executeEditorCommand('underline');
                break;

            case 'ul':
                self.executeEditorCommand('insertunorderedlist');
                break;

            case 'unlink':
                self.executeEditorCommand('unlink');
                break;

            default:
                self.loadPlugin(command);
                self.executePlugin(command);
                break;
        }
    }
    else {
        if (command == 'source') {
            self.switchNormalMode();
        }
        else {
            alert(self.getLang("SourceModeError"));
        }
    }
};
//check command tool is plugin
STEditor.prototype.isPlugin = function (command) {
    var sysCommands = ['anchor', 'b', 'bg_color', 'center', 'fscreen', 'full', 'fore_color', 'hr', 'i', 'img', 'left', 'link', 'ol', 'right', 'remove_format', 's', 'sub', 'sup', 'source', 'u', 'ul', 'unlink'];

    var inSys = STEditor.inArray(command, sysCommands);

    return inSys < 0;
};
//get plugin's instance
STEditor.prototype.getPlugin = function (command) {
    var self = this;
    return STEditor.Plugins[command];
};
//execute plugin's command
STEditor.prototype.executePlugin = function (command) {
    var self = this;
    STEditor.Plugins[command]["Execute"](self);
};
//load plugin files
STEditor.prototype.loadPlugin = function (command) {
    var self = this;

    var pluginBaseUrl = self.BaseUrl + 'plugins/' + command + '/';
    var pluginLibPath = pluginBaseUrl + command + '.js?v=' + STEditor.AppInfo.Build;
    var pluginLangPath = pluginBaseUrl + 'lang/' + self.Lang + '.js?v=' + STEditor.AppInfo.Build;

    try {
        STEditor.importScript(pluginLangPath);
        STEditor.importScript(pluginLibPath);
    }
    catch (ex) {
        alert(ex);
    }
};

//insert customize ubb code
STEditor.prototype.insertUBB = function (ubbCode) {
    var self = this;
    ubbCode = self.convertUBBToXHTML(ubbCode);
    self.insertHTML(ubbCode);
};
//insert customize html code
STEditor.prototype.insertHTML = function (htmlCode) {
    var self = this;
    if (htmlCode && self.EditMode == 1) {
        self.EditorWindow.focus();
        try {
            self.loadSelection();
            var selectionType = self.Selection.type.toLowerCase();
            if (selectionType != 'control') {
                self.Range.pasteHTML(htmlCode);
            }
            else {
                self.Range.item(0).outerHTML = htmlCode;
            }
        }
        catch (ex) {
            self.executeEditorCommand('insertHTML', htmlCode);
        }
    }
};
//execute toolbar button command
STEditor.prototype.executeEditorCommand = function (command, commandParameters) {
    var self = this;
    self.EditorWindow.focus();
    self.EditorWindow.document.execCommand(command, false, commandParameters);
};

STEditor.prototype.getToolbarItemLinkId = function (toolbarItem) {
    var self = this;
    return 'ToolbarItemButton_' + toolbarItem + '_' + self.TargetId;
};
STEditor.prototype.getToolbarItemIconId = function (toolbarItem) {
    var self = this;
    return 'ToolbarItemIcon_' + toolbarItem + '_' + self.TargetId;
};
//build toolbar items to toolbar panel
STEditor.prototype.loadToolbar = function (toolbarPanel) {
    var self = this;

    var toolbarItems = self.Toolbar;
    if (!toolbarItems) {
        toolbarItems = STEditor.ToolbarConfigs['All'];
    }

    if (toolbarPanel) {
        var html = '';

        for (var key in toolbarItems) {
            var toolbarItem = toolbarItems[key];
            if (toolbarItem == '-') { //seperator of group
                html += '<a href="javascript:void(0);" class="toolbar_seperator">&nbsp;</a>';
            }
            else if (toolbarItem == '|') { //break of group
                html += '<div class="toolbar_line">&nbsp;</div>';
            }
            else {
                if (self.isPlugin(toolbarItem)) {
                    self.loadPlugin(toolbarItem);
                }
                var toolbarItemLinkId = self.getToolbarItemLinkId(toolbarItem);
                var toolbarItemImgId = self.getToolbarItemIconId(toolbarItem);

                title = self.getLang(toolbarItem + "_command") || '';
                html += '<a id="' + toolbarItemLinkId + '" href="javascript:void(0);" class="toolbar_item" data="' + toolbarItem + '" lang="' + self.Lang + '" title="' + title + '"><span id="' + toolbarItemImgId + '" style="background-image:url(\'' + self.BaseUrl + '/themes/' + self.Skin + '/images/tool/' + toolbarItem + '.gif\');" data="' + toolbarItem + '">&nbsp;</span></a>';
            }
        };
        html += '<div style="display:block;clear:both;height:0px;"></div>';
        toolbarPanel.innerHTML = html;

        STEditor.attachEvent(window, "load", function (e) {
            for (var key in toolbarItems) {
                var toolbarItem = toolbarItems[key];
                if (toolbarItem != '-' && toolbarItem != '|') { //bind button events

                    var toolbarItemLinkId = self.getToolbarItemLinkId(toolbarItem);
                    var toolbarItemLink = STEditor.getObject(toolbarItemLinkId);

                    if (toolbarItemLink) {
                        STEditor.attachEvent(toolbarItemLink, "click", function (event) {
                            var btnObj = event.target || window.event.srcElement;
                            var data = btnObj.getAttribute("data");
                            self.executeToolbarItem(data);
                        });

                        var linkCommand = toolbarItemLink.getAttribute("data");
                        var linkLang = toolbarItemLink.getAttribute("lang");
                        if (!toolbarItemLink.getAttribute('title')) {
                            toolbarItemLink.setAttribute('title', STEditor.Lang[linkLang][linkCommand + "_command"]);
                        }
                    }
                }
            }
        });
    };
};
//initialize
STEditor.prototype.init = function () {
    var self = this;

    var target = STEditor.getObject(self.TargetId);
    if (!target) {
        return;
    }

    if (!STEditor.isset(STEditor.Lang[self.Lang])) {
        STEditor.Lang[self.Lang] = {};
    }
    self.BaseUrl = STEditor.getBaseUrl();
    self.buildStyleSheet();
    self.buildLangScript();

    var targetName = target.name;
    var targetDefaultValue = target.value;
    var targetWidth = target.offsetWidth;
    var targetHeight = target.offsetHeight;
    var targetParent = target.parentNode;
    if (typeof (self.Size.Width) != 'number') {
        self.Size.Width = targetWidth;
    }
    if (typeof (self.Size.Height) != 'number') {
        self.Size.Height = targetHeight;
    }

    //build editor container
    var container = document.createElement("div");
    container.setAttribute('id', self.TargetId + '_EditorContainer');
    container.setAttribute('lang', self.Lang);
    container.style.width = targetWidth + 'px';
    container.className = "STEditorContainer_" + self.Skin;
    targetParent.appendChild(container);
    targetParent.replaceChild(container, target);
    self.Offset.Position = container.style.position;
    self.Offset.Top = container.style.top;
    self.Offset.Left = container.style.left;
    self.Offset.ZIndex = container.style.zIndex;

    //build input[hidden] form item to save ubb content
    var formInput = document.createElement("textarea");
    formInput.style.display = 'none';
    formInput.id = self.TargetId;
    formInput.name = targetName;
    container.appendChild(formInput);
    self.FormInput = formInput;

    //build toolbar panel
    var toolbarPanel = document.createElement("div");
    toolbarPanel.setAttribute('id', self.TargetId + '_ToolbarPanel');
    toolbarPanel.className = "STEditorToolbarPanel";
    container.appendChild(toolbarPanel);
    self.loadToolbar(toolbarPanel);
    var toolbarHeight = toolbarPanel.offsetHeight;

    //build Factory container
    var factoryBox = document.createElement("div");
    factoryBox.setAttribute('id', self.TargetId + '_EditorFactory');
    factoryBox.style.display = 'none';
    container.appendChild(factoryBox);

    //build textarea of source mode
    var sourceText = document.createElement("textarea");
    sourceText.setAttribute('id', self.TargetId + '_SourceBox');
    sourceText.style.padding = '5px';
    sourceText.style.width = (self.Size.Width - 10) + 'px';
    sourceText.style.maxWidth = (self.Size.Width - 10) + 'px';
    sourceText.style.height = (self.Size.Height - toolbarHeight - 15) + 'px';
    sourceText.style.maxHeight = (self.Size.Height - toolbarHeight - 15) + 'px';
    sourceText.style.display = 'none';
    sourceText.className = "source_textbox";
    container.appendChild(sourceText);

    //build editor area
    var editorAreaId = self.TargetId + '_EditorArea';
    var editorIfm = document.createElement('iframe');
    editorIfm.setAttribute('id', editorAreaId);
    editorIfm.setAttribute('frameBorder', '0');
    editorIfm.setAttribute('allowTransparency', 'true');
    editorIfm.style.width = self.Size.Width + 'px';
    editorIfm.style.height = (self.Size.Height - toolbarHeight) + 'px';
    editorIfm.className = "STEditorArea";
    container.appendChild(editorIfm);

    //initialize editor iframe contentWindow
    self.EditorWindow = STEditor.getIFrameWindow(editorAreaId);

    var initHTML = '<!DOCTYPE html><html><head xmlns="http://www.w3.org/1999/xhtml"><meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"><link href="' + self.BaseUrl + 'themes/' + self.Skin + '/editor_area.css?v=' + STEditor.AppInfo.Build + '" rel="stylesheet" type="text/css" /></head><body contentEditable="true" dir="ltr"><p></p></body></html>';
    if (STEditor.getIEVersion() <= 7) {
        self.EditorWindow.document.designMode = 'on';
    }
    self.EditorWindow.document.open();
    self.EditorWindow.document.writeln(initHTML);
    self.EditorWindow.document.close();
    self.EditorWindow.document.body.style.minHeight = (self.Size.Height - toolbarHeight - 15) + 'px';

    //bind events
    STEditor.attachEvent(sourceText, "blur", function (event) {
        var sourceTextBox = STEditor.getObject(self.TargetId + '_SourceBox');
        var sValue = sourceTextBox.value;
        self.EditMode = 1;

        sValue = self.convertUBBToXHTML(sValue);

        self.EditorWindow.document.body.innerHTML = sValue;
        self.setFormInputValue();
    });
    STEditor.attachEvent(self.EditorWindow, "blur", function (event) {
        self.setFormInputValue();
    });
    STEditor.attachEvent(self.EditorWindow, "keypress", function (event) {
        if (self.EditMode == 1) {
            var editPObj = self.EditorWindow.document.getElementsByTagName('p');
            if (!editPObj[0]) {
                self.executeEditorCommand('formatblock', '<p>');
            }
        }
    });

    STEditor.attachEvent(window, "load", function (e) {
        if (self.UBBMode == 1) {
            targetDefaultValue = self.convertUBBToXHTML(targetDefaultValue);
        }
        if (targetDefaultValue) {
            self.EditorWindow.focus();
            var fixedContent = '';
            var fixedTargetValue = targetDefaultValue;
            if (fixedTargetValue.indexOf('<p>') != -1) {
                fixedContent = fixedTargetValue;
            }
            else {
                var targetValueAry = fixedTargetValue.split('<br />');
                for (var t = 0; t < targetValueAry.length; t++) {
                    fixedContent = fixedContent + '<p>' + targetValueAry[t] + '</p>\r\n';
                }
            };
            self.EditorWindow.document.body.innerHTML = fixedContent;
        }
        self.setFormInputValue();
    });
};

