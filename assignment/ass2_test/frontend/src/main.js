// importing named exports we use brackets
import { createPostTile, uploadImage, createElement } from './helpers.js';

// when importing 'default' exports, use below syntax
import API from './api.js';


var token = -1;
var currentPage = 0;
var numb = 5;
const api  = new API('http://127.0.0.1:5000');

function errorAlert(resp) {
	resp.json().then(data=>{alert(data.message)});
}


function loginSuccess() {
	document.getElementById('content').style.display = 'block';
	document.getElementById('login').style.display = 'none';
	getFeed();
}



function handleLoginResponse(resp) {
	if (resp.status == 200) {
		resp.json().then(data=>{
			token = data.token;
			// alert('success');
			loginSuccess();
		});
    } else {
		errorAlert(resp);
	}
}
document.getElementById('loginBtn').onclick = function(){
    const u = document.getElementById('username').value;
    const p = document.getElementById('password').value;
    api.login(u, p).then(response => {
    	handleLoginResponse(response);
    });
};

document.getElementById('signupBtn').onclick = function(){
	const u = document.getElementById('username').value;
    const p = document.getElementById('password').value;
    const e = document.getElementById('email').value;
    const n = document.getElementById('name').value;

    api.signup(u, p, e, n).then(response => {
    	handleLoginResponse(response);
    });
};

document.getElementById('postBtn').onclick = function() {
	const d = document.getElementById('description_text').value;
	const a = document.getElementById('file').value;
	if(a == '') {
		alert('please select an image')
	} else if(d == '') {
		alert('please input some description')
	}
	else {
		const s = document.getElementById('uploadI').src;
		const i = s.substring(s.indexOf('base64,')+('base64,'.length));
		api.post(token, d, i).then(resp=>{
			if(resp.status == 200) {
				alert('success');
				document.getElementById('file').value = '';
				document.getElementById('description_text').value = '';
				document.getElementById('postIMG').innerHTML = '';
			} else {
				errorAlert(resp);
			}
		})
	}
};

document.getElementById('profileBtn').onclick = function() {
	api.getMe(token).then(resp=>{
		if(resp.status == 200) {
			resp.json().then(data=>{
				document.getElementById('ue').innerHTML = data['username'];
				document.getElementById('ne').innerHTML = data['name'];
				document.getElementById('el').innerHTML = data['email'];
				document.getElementById('fg').innerHTML = data['following'].length;
				document.getElementById('fd').innerHTML = data['followed_num'];
				document.getElementById('yt').innerHTML = data['posts'].length;
			})
		} else {
			errorAlert(resp);
		}
	})
}

function getFeed() {
	api.getFeed(token, currentPage, numb).then(response=>{
		if(response.status == 200) {
			response.json().then(data => {
				if(data.posts.length == 0 && currentPage >0) {
					alert('NO MORE')
				}
				currentPage += data.posts.length
				data.posts.reduce((parent, post) => {
					const section = createPostTile(post);
					parent.appendChild(section);

					const date = new Date(post.meta.published*1000);
					const time = date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds()+' '+date.getDate()+'/'+(date.getMonth()+1)+'/'+date.getFullYear();
					section.appendChild(createElement('div', 'Published: '+time, {style:'display:block'}));
					
			        section.appendChild(createElement('button', 'Likes ['+post.meta.likes.length+']',{class:'btn btn-outline-primary btn-sm ml-1 mt-1 mb-1','data-toggle':"modal",'data-target':"#likes_"+post.id}));
			       	section.appendChild(createElement('button', 'Comments ['+post.comments.length+']',{class:'btn btn-outline-primary btn-sm ml-1 mt-1 mb-1','data-toggle':"modal",'data-target':"#comments_"+post.id}));
			       	const likeBtn = createElement('button', 'Like this post',{class:'btn btn-outline-danger btn-sm  ml-1 mt-1 mb-1'});
			       	likeBtn.onclick = function(){
			       		api.like(token, post.id).then(r=>{
			       			if(r.status == 200) {
			       				document.getElementById('large-feed').innerHTML = '';
			       				currentPage = 0;
			       				getFeed();
			       			} else {
			       				errorAlert(r);
			       			}
			       		})

			       	}
					section.appendChild(likeBtn);

					

			        const modal1 = createElement('div',null, {class:'modal fade bd-example-modal-sm',id:'likes_'+post.id,'tabindex':-1,'role':'dialog','aria-hidden':true})
			        const inmodal1 = createElement('div',null,{class:'modal-dialog modal-sm'});
			        const modalContent1 = createElement('div', null, {class:'modal-content'});
			        const modalBody1 = createElement('div', null, {class:'modal-body'});
			        const modalHeader1 = createElement('div',null, {class: 'modal-header'});
			        modalHeader1.appendChild(createElement('h5', 'LIKES USER LIST', {class:'modal-title h4'}))
			        for(var i = 0; i < post.meta.likes.length; i++) {
			        	api.getOther(token, post.meta.likes[i]).then(resp=>{
			        		if(resp.status == 200) {
			        			resp.json().then(data=>{
			        				modalBody1.appendChild(createElement('div', data['username'], {style:'display:block'}))
			        			});
			        		} else {
			        			errorAlert(resp);
			        		}
			        	})
			        }
			       	modalContent1.appendChild(modalHeader1);

			        modalContent1.appendChild(modalBody1);
			        inmodal1.appendChild(modalContent1);
			        modal1.appendChild(inmodal1);
			        section.appendChild(modal1);

			        const modal2 = createElement('div',null, {class:'modal fade bd-example-modal-sm',id:'comments_'+post.id,'tabindex':-1,'role':'dialog','aria-hidden':true})
			        const inmodal2 = createElement('div',null,{class:'modal-dialog modal-lg'});
			        const modalContent2 = createElement('div', null, {class:'modal-content'});
			        const modalBody2 = createElement('div', null, {class:'modal-body'});
			        const modalHeader2 = createElement('div',null, {class: 'modal-header'});
			        modalHeader2.appendChild(createElement('h5', 'COMMENTS LIST', {class:'modal-title h4'}))
			        for(var i = 0; i < post.comments.length; i++) {
						const ddd = new Date(post.comments[i].published*1000);
						console.log(ddd);

			        	const sss = ddd.getHours() + ':' + ddd.getMinutes() + ':' + ddd.getSeconds()+' '+ddd.getDate()+'/'+(ddd.getMonth()+1)+'/'+ddd.getFullYear();  
			        	console.log(sss);
			        	
			        	modalBody2.appendChild(createElement('div', post.comments[i].author+'('+sss+'): '+post.comments[i].comment, {style:'display:block'}))
			        }
			       	modalContent2.appendChild(modalHeader2);

			        modalContent2.appendChild(modalBody2);
			        inmodal2.appendChild(modalContent2);
			        modal2.appendChild(inmodal2);
			        section.appendChild(modal2);
			        
			        
			        return parent;
			    }, document.getElementById('large-feed'))
			});
		} else {
			errorAlert(response);
		}
	});
}

document.getElementById('moreBtn').onclick = function() {
	getFeed();
}



// Potential example to upload an image
const input = document.querySelector('input[type="file"]');

input.addEventListener('change', uploadImage);

