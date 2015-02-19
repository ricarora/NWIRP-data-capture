//add crime name

//function toggle create/select
//know what the select element is - selector for grabbing existing element, what the create element is [html input], id for input so remove later

$(function() {
  var crimeNameInput = '<div><input id="newCrime" name="conviction[crime_name]" type="text"><a href="#" class="remove_field">Remove field</a></div>';
  $("#add_crime_name").click(function(event) {
    event.preventDefault();
    $(".crime_name_group").val(null)
    $(".crime_name_field").append(crimeNameInput);
    $(".crime_name_group").prop('disabled', true);
    $("#add_crime_name").hide();
  });

  $(".crime_name_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
    $(".crime_name_group").prop('disabled', false);
    $("#add_crime_name").show();
  });
});

//add subsection
$(function() {
  var subsectionInput = '<div><input id="newSubsection" name="conviction[subsection]" type="text"><a href="#" class="remove_field">Remove field</a></div>';
  $("#add_subsection").click(function(event) {
    event.preventDefault();
    $(".subsection_group").val(null)
    $(".subsection_field").append(subsectionInput);
    $(".subsection_group").prop('disabled', true);
    $("#add_subsection").hide();
  });

  $(".subsection_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
    $(".subsection_group").prop('disabled', false);
    $("#add_subsection").show();
  });
});

//add nta-charges
$(function() {
  var ntaChargesInput = '<div><input id="newNtaCharges" name="conviction[nta_charges]" type="text"><a href="#" class="remove_field">Remove field</a></div>';
  $("#add_nta_charges").click(function(event) {
    event.preventDefault();
    $(".nta_charges_group").val(null)
    $(".nta_charges_field").append(ntaChargesInput);
    $(".nta_charges_group").prop('disabled', true);
    $("#add_nta_charges").hide();
  });

  $(".nta_charges_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
    $(".nta_charges_group").prop('disabled', false);
    $("#add_nta_charges").show();
  });
});
