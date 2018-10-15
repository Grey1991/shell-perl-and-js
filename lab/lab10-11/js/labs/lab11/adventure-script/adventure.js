(function () {
    'use strict';
    // code here
    let player = document.getElementById('player');
    let rect = player.getBoundingClientRect();
    let left = rect.left;
    let top = rect.top;

    let speed = 10;
    let flag = 0;



    document.addEventListener('keypress',function(event){
        if (event.code == 'KeyZ'){
            speed = (speed == 10)? 30:10;
            // console.log('speed is '+speed);
        }else if (event.code == 'KeyX') {

            let fireball = document.createElement('div');
            fireball.id = 'fireball';
            fireball.style.backgroundImage = 'url("imgs/fireball.png")';
            fireball.style.position = 'absolute';
            fireball.style.width = '200px';
            fireball.style.height = '150px';
            fireball.style.backgroundSize = 'cover';
            fireball.style.animationName = 'hover';
            fireball.style.animationDuration = '2s';
            // fireball.style.animationIterationCount = 'infinite';
            fireball.style.top = player.style.top;
            fireball.style.left = player.style.left;
            // console.log('fireball start left '+player.style.left);
            document.body.appendChild(fireball);
            
            let start = Date.now();
            let timer = setInterval(function(){
                let timePassed = Date.now() - start;

                if (timePassed >= 2000){
                    console.log('here');
                    clearInterval(timer);
                    document.body.removeChild(fireball);
                    return;
                }
                fireball.style.left = parseInt(player.style.left,10) + timePassed  + 'px';
                // console.log('fireball left '+ fireball.style.left);
                
            }, 20);
        }else if (event.code == 'KeyC'){
            if (flag == 0){
                player.style.backgroundImage = 'url("imgs/wnh.png")';
                player.style.backgroundSize = 'contain';
                player.style.width = '70px';
                flag = 1;
            }else {
                player.style.backgroundImage = 'url("imgs/ghost.png")';
                player.style.backgroundSize = 'cover';
                player.style.width = '106px';
                flag = 0;
            }
            
        }
    });
        
    function move(e) {

        if (e.keyCode == 40) {
            top += speed;
            player.style.top = top + 'px';
        }
        if (e.keyCode == 39) {
            left += speed;
            player.style.left = left + 'px';
        }
        if (e.keyCode == 37) {
            left -= speed;
            player.style.left = left + 'px';
        }
        if (e.keyCode == 38) {
            top -= speed;
            player.style.top = top + 'px';
        }
    }
    // document.onkeypress = speed_up;
    document.onkeydown = move;
}());
