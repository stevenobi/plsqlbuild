/**
 *
 * Javascript Type Functions for APEX and other Web Application Frameworks
 *
 * @created Nov 2017
 *
 * @author Stefan Obermeyer
 *
 * @version 0.1.0 24.10.2017 SOB: created
 * 
 **/

/**
 * @namespace Welcome (O's Javascript Welcome Starter Pack)
 **/
var Welcome = {};

Welcome.Text = function(t) {
    // constructor
    this.text = t;
  // end of Method Text
    return (this.text);
};

// plain old js, if no libs are loaded
function hello(txt) {
    var w = new Welcome.Text(txt);
    var span = document.createElement('span');
    span.className = 'greeting-row';
    span.innerHTML = w.text;
    document.getElementById('greeting').appendChild(span);
};

setTimeout(function(){ 
    hello("Hello Visitor :-)"); 
}, 1000);
