$(document).keyup(function(){
	if(event.keyCode === "78"){
		window.location.href = "/ingredients/new";
		event.preventDefault();
	}
});