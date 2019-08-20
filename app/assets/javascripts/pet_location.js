var ENTER_KEY_CODE = 13;

function initializeLocationServices() {
  var addressInput = document.getElementById('pet_address');
  var autocomplete = new google.maps.places.Autocomplete(
    addressInput,
    {types: ['geocode', 'establishment']}
  );

  toggleSubmitButtonState({'disabled': true});
  preventFormSubmitOnEnter(addressInput);

  autocomplete.setFields(['geometry']);
  autocomplete.addListener('place_changed', handlePlaceSelect.bind(this, autocomplete));
}

function toggleSubmitButtonState(attributes) {
  $('#btn-submit').attr(attributes);
}

function preventFormSubmitOnEnter(addressInput) {
  google.maps.event.addDomListener(addressInput, 'keydown', function (event) {
    if (event.keyCode === ENTER_KEY_CODE) {
      event.preventDefault();
    }
  });
}

function initializeMap(latitude, longitude) {
  return new google.maps.Map(document.getElementById('pet-map'), {
    center: {lat: latitude, lng: longitude},
    zoom: 15
  });
}

function createMarker(map, latitude, longitude) {
  return new google.maps.Marker({
    map: map,
    draggable: true,
    position: {lat: latitude, lng: longitude}
  });
}

function handlePlaceSelect(autocomplete) {
  var coordinates = autocomplete.getPlace().geometry.location;
  var latitude = coordinates.lat();
  var longitude = coordinates.lng();
  var addressInput = $('#pet_address');
  var latitudeInput = $('#pet_latitude');
  var longitudeInput = $('#pet_longitude');
  var mapDiv = $('#pet-map');

  latitudeInput.val(latitude);
  longitudeInput.val(longitude);

  toggleSubmitButtonState({'disabled': false});

  var map = initializeMap(latitude, longitude);
  var marker = createMarker(map, latitude, longitude);

  mapDiv.show();

  google.maps.event.addListener(marker, 'dragend', function () {
    var newCoordinates = marker.getPosition();
    var geocoder = new google.maps.Geocoder();
    map.panTo(newCoordinates);
    latitudeInput.val(newCoordinates.lat());
    longitudeInput.val(newCoordinates.lng());
    geocoder.geocode({latLng: newCoordinates}, function (results) {
        addressInput.val(results[0].formatted_address);
      }
    );
  });
}
