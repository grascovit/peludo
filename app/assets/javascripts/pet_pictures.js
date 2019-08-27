var INVALID_FILE_TYPE = /^((?!image\/).)*$/;

function checkFilesForErrors(files) {
  var error = null;
  var picturesInput = $('#pet_pictures');
  var MINIMUM_PICTURES_COUNT = picturesInput.data('min-pictures-count');
  var MAXIMUM_PICTURES_COUNT = picturesInput.data('max-pictures-count');

  if (files.length < MINIMUM_PICTURES_COUNT || files.length > MAXIMUM_PICTURES_COUNT) {
    error = picturesInput.data('pictures-out-of-range-error');
  }

  for (var i = 0; i < files.length; i++) {
    var file = files[i];

    if (INVALID_FILE_TYPE.test(file.type)) {
      error = picturesInput.data('pictures-invalid-type-error');
      break;
    }
  }

  return error;
}

function addFilesToDiv(files) {
  for (var i = 0; i < files.length; i++) {
    var file = files[i];
    var pictureDiv = $('<p></p>', { class: 'picture-to-upload' }).text(file.name);

    $('.pictures').append(pictureDiv);
  }
}

function handleFileSelectionError(picturesInput, error) {
  picturesInput.val('');

  $.toast({
    text: error,
    position: 'top-center',
    hideAfter: 5000,
    icon: 'error'
  });
}

function handlePicturesSelection() {
  var files = $(this).prop('files');
  var error = checkFilesForErrors(files);

  $('.picture-to-upload').remove();

  error ? handleFileSelectionError($(this), error) : addFilesToDiv(files);
}

$(document).ready(function () {
  $('#pet_pictures').change(handlePicturesSelection);
});
