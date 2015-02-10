//add crime name
$(function() {
  var crimeNameInput = '<div><input id="newCrime" name="conviction[crime_name]" type="text"><a href="#" class="remove_field">Remove field</a></div>';
  $("#add_crime_name").click(function(event) {
    event.preventDefault();
    $(".crime_name_field").append(crimeNameInput);
    $(".crime_name_group").prop('disabled', true);
  });

  $(".crime_name_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
    $(".crime_name_group").prop('disabled', false);
  });
});

//add subsection
$(function() {
  var subsectionInput = '<div><input id="newSubsection" name="conviction[subsection]" type="text"><a href="#" class="remove_field">Remove field</a></div>';
  $("#add_subsection").click(function(event) {
    event.preventDefault();
    $(".subsection_field").append(subsectionInput);
    $(".subsection_group").prop('disabled', true);
  });

  $(".subsection_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
    $(".subsection_group").prop('disabled', false);
  });
});

//add nta-charges
$(function() {
  var ntaChargesInput = '<div><input id="newNtaCharges" name="conviction[nta_charges]" type="text"><a href="#" class="remove_field">Remove field</a></div>';
  $("#add_nta_charges").click(function(event) {
    event.preventDefault();
    $(".nta_charges_field").append(ntaChargesInput);
    $(".nta_charges_group").prop('disabled', true);
  });

  $(".nta_charges_field").on("click",".remove_field", function(event){ //user click on remove text
    event.preventDefault(); $(this).parent('div').remove();
    $(".nta_charges_group").prop('disabled', false);
  });
});
