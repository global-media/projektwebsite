var ContactUs = function () {

    return {
        //main function to initiate the module
        init: function () {
			var map;
			$(document).ready(function(){
			  map = new GMaps({
				div: '#map',
				lat: -6.175147, // -13.004333,
				lng: 106.827153 // -38.494333 
			  });
			   var marker = map.addMarker({
		            lat: -6.175147, //-13.004333,
					      lng: 106.827153, // -38.494333,
		            title: 'Default Admin',
		            infoWindow: {
		                content: "<b>Default Admin.</b> Street1, Street2<br> Jakarta, Indonesia"
		            }
		        });

			   marker.infoWindow.open(map, marker);
			});
        }
    };

}();