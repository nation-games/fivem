$(function(){
	window.addEventListener('message', function(event) {
		if(event.data.showhud == true){
			$('.huds').fadeIn();
			setProgressSpeed(event.data.speed,'.progress-speed');
		}
	 	if (event.data.action == "toggleCar"){
			if (event.data.show){
				$('.carStats').fadeIn();
			} else{
				$('.carStats').fadeOut();
			}
		} 
	});

});

function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/170;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*100)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;
    html.text(value);
  }

