function hideReliefs() {
  $(".relief").each(function() {
    var relief = $(this)
    if (shouldHideRelief(relief)) {
      $(relief).addClass("hidden");
    }
    $(relief).find(".remove_field").click(function(event) { //remove click function
      event.preventDefault();
      ($(relief).find(".relief-options").val(null)) //sets value back to default
      $(relief).addClass("hidden"); //hides relief input
    });
  });

  $("#show-relief").click(function(event) {
    event.preventDefault();
    $('.hidden.relief').first().removeClass("hidden") // removes hidden class from the top hidden
  });
}

function shouldHideRelief(relief) {
  if ($(relief).is("#relief-0")) {
    return false;
  }
  else if ($(relief).find(".relief-options").val()) {
    return false;
  }
  else {
    return true;
  }
}

//
// function hideAssessments() {
//   $(".assessment").each(function() {
//     var assessment = $(this)
//     if (shouldHideAssessment(assessment)) {
//       $(assessment).addClass("hidden");
//     }
//     $(assessment).find(".remove_field").click(function(event) {
//       event.preventDefault();
//       ($(assessment.find(".date")).val(null))
//       $(assessment).addClass("hidden");
//     });
//   });
//
//   $("#show-assessment").click(function(event) {
//     event.preventDefault();
//     $('.hidden.assessment').first().removeClass("hidden")
//   });
// }
//
// function shouldHideAssessment(assessment) {
//   if ($(assessment).is("#assessment-0")) {
//     return false;
//   }
//   else if ($(assessment.find(".date")).val()) { //need to figure out how to check value
//     return false;
//   }
//   else {
//     return true;
//   }
// }


$(function() {
  hideReliefs();
 // hideAssessments();
});
