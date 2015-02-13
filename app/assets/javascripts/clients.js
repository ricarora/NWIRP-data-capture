// Place all the behaviors and hooks related to the matching controller here.//
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function IndexNumber(class_name, field_type) {
  // checking if data-index exist for an empty field, if it does it increments the last data-index by 1
  // if there is no data-index, it sets it to zero
  $data = $("." + class_name + " " + field_type + ":last").data()
  if ( $data != null || undefined) {
    return $data.index + 1
  } else {
    return 0
  }
}



function SelectOptionsGenerator(arr) {
  str = "<option value>Please select</option>";
  for(i=0; i < arr.length; i++ ) {
    str = str + "<option value=" + arr[i].name + ">" + arr[i].name + "</option>"
  }
  return str
}

function addReliefField(first, dropDownOptions) {
  //adding an empty field to relief field in client form. Also, add a remove link with it.
  var remove = first ? "</div>" : "<a href='#' class='remove_field'>Remove field</a></div>";
  var emptyField = "<div> <select data-index="+ IndexNumber("relief_field", "select") +" class='client_client_reliefs_attributes_0_relief_name' name=client[client_reliefs_attributes][" + IndexNumber("relief_field", "select") + "][relief_name]>" + dropDownOptions + "</select>";
  emptyField = emptyField + remove;
  $(".relief_field").append(emptyField);
}

function addAssessmentField(first) {
  //adding an empty field to relief field in client form. Also, add a remove link with it.
  var remove = first ? "</div>" : "<a href='#' class='remove_field'>Remove field</a></div>";
  var emptyField = "<div><input data-index=" + IndexNumber("assessment_field", "input") + " id='client_assessments_attributes_0_date' name=client[assessments_attributes][" + IndexNumber("assessment_field", "input") + "][date] type='date'>";
  emptyField = emptyField + remove;
  $(".assessment_field").append(emptyField);
}


$(function() {
  var ArrayOfReliefObjects = $("#relief_sought_options").data('url');
  var dropDownOptionsForRelief = SelectOptionsGenerator(ArrayOfReliefObjects)

  addReliefField(true, dropDownOptionsForRelief);
  $("#add_field").click(function(event) {
    event.preventDefault();
    //find a way to get each of these name values different for params
    addReliefField(false, dropDownOptionsForRelief);
  });

  $(".relief_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
  });

  addAssessmentField(true);
  $("#add_assessment_field").click(function(event) {
    event.preventDefault();
    //find a way to get each of these name values different for params
    addAssessmentField(false);
  });

  $(".assessment_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
  });

});
