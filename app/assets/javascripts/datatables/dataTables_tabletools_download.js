TableTools.BUTTONS.download = {
    "sAction": "text",
    "sTag": "default",
    "sFieldBoundary": "",
    "sFieldSeperator": "\t",
    "sNewLine": "<br>",
    "sToolTip": "",
    "sButtonClass": "DTTT_button_text",
    "sButtonClassHover": "DTTT_button_text_hover",
    "sButtonText": "Download",
    "mColumns": "all",
    "bHeader": true,
    "bFooter": true,
    "sDiv": "",
    "fnMouseover": null,
    "fnMouseout": null,
    "fnClick": function( nButton, oConfig ) {
      var oParams = this.s.dt.oApi._fnAjaxParameters( this.s.dt );
    var iframe = document.createElement('iframe');
    iframe.style.height = "0px";
    iframe.style.width = "0px";
    iframe.src = oConfig.sUrl+"&"+$.param(oParams);
    document.body.appendChild( iframe );
    },
    "fnSelect": null,
    "fnComplete": null,
    "fnInit": null
};