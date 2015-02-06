// Place all the behaviors and hooks related to the matching controller here.//
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function addReliefField(first) {
  var remove = first ? '</div>' : '<a href="#" class="remove_field">Remove field</a></div>';
  var emptyField = '<div><input id="client_build_form_relief_name" name="client_build_form[relief_name][]" type="text">';
  emptyField = emptyField + remove;
  $(".relief_field form").append(emptyField);
}

$(function() {
  addReliefField(true);
  $("#add_field").click(function(event) {
    event.preventDefault();
    //find a way to get each of these name values different for params
    addReliefField(false);
  });

  $(".relief_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
  });

});
