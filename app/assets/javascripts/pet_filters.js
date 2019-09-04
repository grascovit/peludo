function handleFilterSelection() {
  $('form').submit();
}

$(document).ready(function () {
  $('#breed_id, #gender, #address').change(handleFilterSelection);
});
