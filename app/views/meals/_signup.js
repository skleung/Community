$(document).ready(function(){
	var MEAL_CLASS = "meal";

	//EVENT BINDINGS	
	$(".calendar").click(function(event){
		var $target = $(event.target);
		$(".alert-block").fadeIn();
		if ($target.attr('class').indexOf(MEAL_CLASS) > -1){
			//selected a meal
			var meal_ids = $target.attr('data_meal_ids') 
			console.log('meal ids = '+meal_ids);			
		}
	});

});



