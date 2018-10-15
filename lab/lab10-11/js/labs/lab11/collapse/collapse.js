(function() {
  'use strict';
  // TODO: Write some js
  document.getElementById('item-1').addEventListener('click',function(){
    collapse('item-1');
  });
  document.getElementById('item-2').addEventListener('click',function(){
    collapse('item-2');
  });
  function collapse(btn){
    document.getElementById(btn+'-content').style.display = 'none';
  }
}());
