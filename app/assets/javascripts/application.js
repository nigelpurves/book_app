// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
// Changed the order of the below to put require jquery after require bootstrap because dropdowns weren't working
//
// = require jquery
// = require jquery_ujs
// = require jquery-ui
// = require bootstrap
// = require artist_autocomplete
// = require bootstrap-tooltip.js
// = require bootstrap-popover.js



// require_tree .

$(".js-disable").each(function(i, e) {
  $(e).click(function() {
    alert("Drag this bookmarklet to your toolbar and use it on sites like youtube and soundcloud to track stuff on qusic!");
    return false
  });
});

$(function ()  
{ $(".popoverhiw").popover({placement: 'right'});  
});