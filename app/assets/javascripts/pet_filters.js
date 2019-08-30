function initializeAddressFilter() {
  var addressInput = document.getElementById('address');
  var autocomplete = new google.maps.places.Autocomplete(
    addressInput,
    { types: ['geocode', 'establishment'] }
  );

  autocomplete.addListener('place_changed', filterPets);
}

function filterPets() {
  $('form').submit();
}

$(document).ready(function () {
  $('#breed_id, #gender').change(function () {
    filterPets();
  });
});
