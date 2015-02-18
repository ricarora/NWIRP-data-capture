// Place all the behaviors and hooks related to the matching controller here.//
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function hideReliefs() {
  $(".relief").each(function() {
    var relief = $(this)
    if (shouldHideRelief(relief)) {
      $(relief).addClass("hidden");
    }
    $(relief).find(".remove_field").click(function(event) {
      event.preventDefault();
      $(relief).addClass("hidden");
    });
  });

  $("#show-relief").click(function(event) {
    event.preventDefault();
    $('.hidden.relief').first().removeClass("hidden") // removes hidden class to all children
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


function hideAssessments() {
  $(".assessment").each(function() {
    var assessment = $(this)
    if (shouldHideAssessment(assessment)) {
      $(assessment).addClass("hidden");
    }
    $(assessment).find(".remove_field").click(function(event) {
      event.preventDefault();
      $(assessment).addClass("hidden");
    });
  });

  $("#show-assessment").click(function(event) {
    event.preventDefault();
    $('.hidden.assessment').first().removeClass("hidden") // removes hidden class to all children
  });
}

function shouldHideAssessment(assessment) {
  if ($(assessment).is("#assessment-0")) {
    return false;
  }
  // else if ($(assessment).find(".relief-options").val()) {
  //   return false;
  // }
  else {
    return true;
  }
}



$(function() {
 hideReliefs();
 //hideAssessments();
});
