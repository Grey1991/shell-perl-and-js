(function() {
  'use strict';
  // TODO: Write some js
  document.getElementById('item-1').addEventListener('click',function(){
    collapse_expend('item-1');
  });
  document.getElementById('item-2').addEventListener('click',function(){
    collapse_expend('item-2');
  });
  function collapse_expend(btn){
    let icon = document.getElementById(btn).innerHTML;
    console.log(icon);
    if (icon == 'expand_less'){
      console.log('here');
      document.getElementById(btn).innerHTML = 'expand_more';
      document.getElementById(btn+'-content').style.display = 'none';      
    }else {
      document.getElementById(btn).innerHTML = 'expand_less';
      document.getElementById(btn+'-content').style.display = '';   
    }
  }
}());
