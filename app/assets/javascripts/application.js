//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap
//= require select2.min
//= require i18n/pt-BR
//= require_tree .

$(document).ready(function () {
  $('select').select2({
    theme: 'bootstrap4',
    language: 'pt-BR'
  });
});
