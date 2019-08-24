addEventListener('direct-upload:initialize', function (event) {
  var progressBarDiv = $('<div></div>', { class: 'progress-bar', role: 'progressbar' });
  var progressDiv = $('<div></div>', { class: 'progress progress-upload' }).append(progressBarDiv);
  var picturesDiv = $('.pictures');
  picturesDiv.append(progressDiv);
  progressDiv.show();
});

addEventListener('direct-upload:progress', function (event) {
  var progress = parseInt(event.detail.progress);
  var progressBar = $('.progress-bar');
  progressBar.css('width', progress + '%');
  progressBar.text(progress + '%');
});

addEventListener('direct-upload:error', function (event) {
  event.preventDefault();

  $.toast({
    text: $(event.target).data('picture-upload-error-message'),
    position: 'top-center',
    hideAfter: 5000,
    icon: 'error'
  });
});

addEventListener('direct-upload:end', function (event) {
  $('.progress-upload').remove();
});
