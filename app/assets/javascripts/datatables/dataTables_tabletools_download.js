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
        // Sinapse: add date-range parameters, which are not included in _fnAjaxParamters
        for ( var i=0 ; i<oConfig.sExtraData.length ; i++ ) {
            var clave = "sSearch_" + oConfig.sExtraData[i];
            var valor = ( $("#" + oConfig.sInputName + "_range_from_" + oConfig.sExtraData[i] ).val() ) + "~" + ( $("#" + oConfig.sInputName + "_range_to_" + oConfig.sExtraData[i] ).val() );
            if( valor != "~" ) {
                var parametro = { "name": clave, "value": valor };
                oParams = oParams.concat( parametro );
            }
        }
        // end of Sinapse
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

// TableTools.BUTTONS.download = {
//     "sAction": "text",
//     "sTag": "default",
//     "sFieldBoundary": "",
//     "sFieldSeperator": "\t",
//     "sNewLine": "<br>",
//     "sToolTip": "",
//     "sButtonClass": "DTTT_button_text",
//     "sButtonClassHover": "DTTT_button_text_hover",
//     "sButtonText": "Download",
//     "mColumns": "all",
//     "bHeader": true,
//     "bFooter": true,
//     "sDiv": "",
//     "fnMouseover": null,
//     "fnMouseout": null,
//     "fnClick": function( nButton, oConfig ) {
//         var oParams = this.s.dt.oApi._fnAjaxParameters( this.s.dt );
//         var aoPost = [
//             { "name": "hello", "value": "world" }
//         ];
//         var aoGet = [];
 
//         /* Create an IFrame to do the request */
//         nIFrame = document.createElement('iframe');
//         nIFrame.setAttribute( 'id', 'RemotingIFrame' );
//         nIFrame.style.border='0px';
//         nIFrame.style.width='0px';
//         nIFrame.style.height='0px';
             
//         document.body.appendChild( nIFrame );
//         var nContentWindow = nIFrame.contentWindow;
//         nContentWindow.document.open();
//         nContentWindow.document.close();
         
//         var nForm = nContentWindow.document.createElement( 'form' );
//         nForm.setAttribute( 'method', 'post' );
         
//         /* Add POST data */
//         for ( var i=0 ; i<aoPost.length ; i++ )
//         {
//             nInput = nContentWindow.document.createElement( 'input' );
//             nInput.setAttribute( 'name', aoPost[i].name );
//             nInput.setAttribute( 'type', 'text' );
//             nInput.value = aoPost[i].value;
             
//             nForm.appendChild( nInput );
//         }
         
//         /* Add GET data to the URL */
//         var sUrlAddition = '';
//         for ( var i=0 ; i<aoGet.length ; i++ )
//         {
//             sUrlAddition += aoGet[i].name+'='+aoGet[i].value+'&';
//         }
         
//         nForm.setAttribute( 'action', oConfig.sUrl );
         
//         /* Add the form and the iframe */
//         nContentWindow.document.body.appendChild( nForm );
         
//         /* Send the request */
//         nForm.submit();
//     },
//     "fnSelect": null,
//     "fnComplete": null,
//     "fnInit": null
// };