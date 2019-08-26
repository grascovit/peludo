function handlePicturesSelection() {
  var files = $(this).prop('files');

  $('.picture-to-upload').remove();

  for (var i = 0; i < files.length; i++) {
    var file = files[i];
    var pictureDiv = $('<p></p>', { class: 'picture-to-upload' }).text(file.name);

    $('.pictures').append(pictureDiv);
  }
}

$(document).ready(function () {
  $('#pet_pictures').change(handlePicturesSelection);
});
