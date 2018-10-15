(function() {
   'use strict';
   // write your js here.
   setInterval(addHide, 2000);
   function addHide() {
       let output_class = document.getElementById('output').className;
       output_class = (output_class == 'hide')? '':output_class = 'hide';
       document.getElementById('output').className = output_class;
   }
}());
