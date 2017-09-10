function change_pic(){
	$('#hsd_details').hide();
	$('#ud_details').hide();
	$('#upload_pic').show();
}
$(document).ready(function (e) {
	$("#form_upload_pic").on('submit',(function(e) {
	e.preventDefault();
	$("#message").empty();
	$('#loading').show();
	$.ajax({
	url: "ajax_profilepic_upload", // Url to which the request is send
	type: "POST",             // Type of request to be send, called as method
	data: new FormData(this), // Data sent to server, a set of key/value pairs (i.e. form fields and values)
	contentType: false,       // The content type used when sending data to the server.
	cache: false,             // To unable request pages to be cached
	processData:false,        // To send DOMDocument or non processed data file it is set to false
	success: function(data)   // A function to be called if request succeeds
	{
	$('#loading').hide();
	$("#message").html(data);
	}
	});
	}));
	
	$('#form_hsd_details').on('submit',(function(e){
		e.preventDefault();
		$('#hsd_details_saving').show();
		$.ajax({
			url: "savehsd",
			type: "POST",
			data: "school_name="+document.getElementById("school_name").value+"&school_from="+document.getElementById("school_from").value+"&school_to="+document.getElementById("school_to").value,
			succes: function(data){
				$('#hsd_details_saving').hide();
				$('#hsd_output').html(data);
			}
		})
	}))
	
	$('#form_ud_details').on('submit',(function(e){
		e.preventDefault();
		$('#ud_details_saving').show();
		$.ajax({
			url: "saveud",
			type: "POST",
			data: "",
			succes: function(data){
				$('#ud_details_saving').hide();
				$('#ud_output').html(data);
			}
		})
	}))
});
	
function save_image(img_path){
	alert("working...");
	$('#pic_saved').show();
}

function add_hsd(){
	$('#upload_pic').hide();
	$('#ud_details').hide();
	$('#hsd_details').show();
	$('#hsd_details1').show();
}
function save_hsd(schoolname,from,to){
	alert("hiii");
	alert("the school name is : "+schoolname+" started on :"+from+" and ended on :"+to);
	var request = $.ajax({
		url: "savehsd",
		type: "GET",
		data: "sname="+schoolname+"&from="+from+"&to="+to
	});
	request.done(function(msg){
		$('#hsd_ajax_res').html(msg);
	});
	request.fail(function(jqXHR, textStatus){
		alert("Request failed: "+textStatus);
	});
	
	document.getElementById("hsd_details").innerHTML+="<font color='green'>Data saved!</font>"
}


function add_ud(){
	$('#hsd_details').hide();
	$('#upload_pic').hide();
	$('#ud_details').show();
}
function save_ud(clgname,from,to){
	alert("The clg name is :"+clgname+" started on :"+from+" and ended on :"+to);
	document.getElementById("ud_details").innerHTML+="<font color='green'>College Details Saved</font>"
}

