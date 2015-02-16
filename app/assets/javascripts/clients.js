// Place all the behaviors and hooks related to the matching controller here.//
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function IndexNumber(class_name, field_type) {
  // checking if data-index exist for an empty field, if it does it increments the last data-index by 1
  // if there is no data-index, it sets it to zero
  $data = $("." + class_name + " " + field_type + ":last").data()
  // $data = $("." + class_name + " " + "div" + " " + field_type + ":last").data()
  // commented out works with assessment after Matt's changes
  if ( $data != null || undefined) {
    return $data.index + 1
  } else {
    return 0
  }
}

function SelectOptionsGenerator(arr) {
  str = "<option value>Please select</option>";
  for(i=0; i < arr.length; i++ ) {
    str = str + "<option value='" + arr[i].name + "'>" + arr[i].name + "</option>"
  }
  return str
}

function selectRelief() {
  var reliefs = $(".relief_fields")
  debugger
  for(i=0; i < reliefs.length; i++) {
    //var options = $(".client_client_reliefs_attributes_0_relief_name")
    //reliefs[i]
    var optionarray = $(".client_client_reliefs_attributes_0_relief_name")[i].options
    for(i=0; i < optionarray.length; i++ ) {
      var selected = $(".relief_fields").data("reliefs")
      //this should work?!?!?
      //need to find the option where the value matches
      $(".client_client_reliefs_attributes_0_relief_name")[0].options.find("[value='" + selected + "']");
      //throw in selected in that option
    }
  }
}


function addReliefField(first, dropDownOptions) {
  //adding an empty field to relief field in client form. Also, add a remove link with it.
  var remove = first ? "</div>" : "<a href='#' class='remove_field'>Remove field</a></div>";
  var emptyField = "<div> <select data-index=" + IndexNumber("relief_fields", "select") + " class='client_client_reliefs_attributes_" + IndexNumber("relief_fields", "select") + "_relief_name' name=client[client_reliefs_attributes][" + IndexNumber("relief_fields", "select") + "][relief_name]>" + dropDownOptions + "</select>";
  emptyField = emptyField + remove;
  $(".relief_fields").append(emptyField);
  selectRelief()
}

function addAssessmentField() {
  //adding an empty field to relief field in client form. Also, add a remove link with it.
  var remove = "<a href='#' class='remove_field'>Remove field</a></div>";
  var emptyField = "<div><input data-index=" + IndexNumber("assessment_fields", "input")
  + " id='client_assessments_attributes_" + IndexNumber("assessment_fields", "input")
  + "_date' name=client[assessments_attributes]["
  + IndexNumber("assessment_fields", "input")
  + "][date] type='date'>";
  emptyField = emptyField + remove;
  $(".assessment_fields").append(emptyField);
}


$(function() {
  var ArrayOfReliefObjects = $("#relief_sought_options").data('url');
  var dropDownOptionsForRelief = SelectOptionsGenerator(ArrayOfReliefObjects)

  addReliefField(true, dropDownOptionsForRelief);
  $("#add_field").on('click', function(event) {
    console.log("lolclick: ", event);
    event.preventDefault();
    //find a way to get each of these name values different for params
    addReliefField(false, dropDownOptionsForRelief);
  });

  $(".relief_fields").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
  });

  $("#add_assessment_field").click(function(event) {
    event.preventDefault();
    addAssessmentField();
  });

  $(".assessment_fields").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
  });

});
