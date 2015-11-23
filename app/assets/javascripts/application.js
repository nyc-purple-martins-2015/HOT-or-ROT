// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require handlebars-205c61c


$(document).ready(function() {

// autocomplete place details

  (function initialize (){  

    var lat = 40.7127,
        lng = -74.0059,
        latlng = new google.maps.LatLng(lat, lng),
        image = 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png';
    
    var myOptions = {
      center: new google.maps.LatLng(lat, lng),
      zoom: 17,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map"), myOptions);
    console.log(map);

    // Get's user's current location
    var input = document.getElementById('searchTextField');         
    console.log(input); 
    
    var autocomplete = new google.maps.places.Autocomplete(input);          
    
    autocomplete.bindTo('bounds', map); 
    var infowindow = new google.maps.InfoWindow(); 

    autocomplete.addListener('place_changed', function() {
        infowindow.close();
        var place = autocomplete.getPlace();
        $('#photo_restaurant').val(place.name);
        
        console.log(place);
    });     
 
 
    //show current location and marker
    navigator.geolocation.getCurrentPosition(function(position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
  
      map.setCenter(initialLocation);

      var marker = new google.maps.Marker({
        position: initialLocation,
        map: map,
        title: 'Hello World!'
      });
    });

}) ();
  

//document ready end
});