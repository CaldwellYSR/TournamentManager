var map;

var initMap = function() {
  let map_element = document.getElementById('venue_map');
  let geocoder = new google.maps.Geocoder();

  let latlng = new google.maps.LatLng(-34.397, 150.644);
  let mapOptions = {
    center: latlng,
    zoom: 15
  }
  map = new google.maps.Map(map_element, mapOptions);

  geocoder.geocode( { 'address': map_element.dataset.address}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      let marker = new google.maps.Marker({
        icon: 'http://local.test:4000/images/tennis-icon.png',
        map: map,
        position: results[0].geometry.location,
        title: map_element.dataset.name
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

