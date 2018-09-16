
$(document).on('turbolinks:load', function(){

  $('#content').on('keyup load',function(){
    str = $(this).val();
    $('#preview').html(marked(str));
  });
});
