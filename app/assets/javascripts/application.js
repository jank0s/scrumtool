// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require ckeditor/init
//= require_tree .
//= require bootstrap.min
//= require bootstrap-datepicker

//= require jsapi 
//= require chartkick
//= require highcharts

$(document).on('ready page:load', function (){
    $("#form-active-project select").change(function() {
        $(this).parents("form").submit();
    });
});


// if other site, do not do this
$(document).ready(function () {
	if(window.location.pathname == '/pokers/new/')
	setInterval(function(){
		$.get("/pokers/new.js", function(data){
			$("#refreshdiv").html(data);
		},
		"html")
	}, 5000);
});

function custom(){
	var customestimate = prompt("Please enter your estimate ","");
	if (isInt(customestimate) || isFloat(customestimate)){
		data = {};
		var entry = "entry";
		data[entry] = customestimate; 
		$.ajax({
		  type: "POST",
		  url: '/pokers/makeentry',
		  data: data,
		  dataType :"json"
		});
	}
	else {
		alert(Write right number!);
	}
};

function isFloat(n) {
    return parseFloat(n)==n && n>0;
};

var isInt = function(n) { 
	return parseInt(n) == n && n>0;
};
