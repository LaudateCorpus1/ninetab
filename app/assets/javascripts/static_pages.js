$(document).ready(function() {  
  $('.flexslider').flexslider({
    slideshow: false,
    prevText: '',
    nextText: ''
  });

  var validationSettings = {
    errorMessagePosition : 'element',
  };

  $('#contact-form')
    .validateOnBlur(jQueryFormLang, validationSettings)
    .submit(function() {
      return $(this).validate(jQueryFormLang)
    });
});