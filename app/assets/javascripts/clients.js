// Place all the behaviors and hooks related to the matching controller here.//
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

//functionality to add new fields to relief sought in new client form

var num = 0;

function addReliefField(first) {
  var max_field = 10;
  if (num < max_field) {
    num += 1;
    var remove = first ? "</div>" : "<a href='#' class='remove_field'>Remove field</a></div>";
    var emptyField = "<div> <select id='client_client_reliefs_attributes_0_relief_name' name=client[client_reliefs_attributes][" + (num - 1) + "][relief_name]><option value>Please select</option><option value='212C; WAIVER IN RMV PROCEED. PERMITTED BY CASE LAW'>212C; WAIVER IN RMV PROCEED. PERMITTED BY CASE LAW</option><option value='245 - ADJUSTMENT OF STATUS'>245 - ADJUSTMENT OF STATUS</option><option value='ASYLUM'>ASYLUM</option><option value='ASYLUM -WITHHOLDING'>ASYLUM -WITHHOLDING</option><option value='CHILD'>CHILD</option><option value='CITIZENSHIP'>CITIZENSHIP</option><option value='COERCIVE POPULATION CONTROL'>COERCIVE POPULATION CONTROL</option><option value='DACA'>DACA</option><option value='DAPA'>DAPA</option></select>";
    emptyField = emptyField + remove;
    $(".relief_field").append(emptyField);
  }
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
