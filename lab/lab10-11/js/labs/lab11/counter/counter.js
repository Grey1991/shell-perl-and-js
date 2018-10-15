(function() {
   'use strict';
   // write your code here
   setInterval(getTime, 1000);
   function getTime() {
       let time = new Date().toLocaleTimeString();
       document.getElementById('output').innerHTML = time;
   }
}());
