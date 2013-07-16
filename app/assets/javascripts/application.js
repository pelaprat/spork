// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {

	var delay = (function(){
	  var timer = 0;
	  return function(callback, ms){
	    clearTimeout (timer);
	    timer = setTimeout(callback, ms);
	  };
	})();

	$('#fieldnote-filter-form input').keyup(function() {
		delay( function() {
			$.get( $('#fieldnote-filter-form').attr('action'), $('#fieldnote-filter-form').serialize(), null, 'script');
			return false;
		}, 250 );
	});

	$('#user-filter-form input').keyup(function() {
		delay( function() {
			$.get( $('#user-filter-form').attr('action'), $('#user-filter-form').serialize(), null, 'script');
			return false;
		}, 250 );
	});

/*	$("#fieldnotes-list .fieldnote-table .header a").live('click', function () {
		alert('etienne');
		$.getScript(this.href);
		return false;
	});
*/

});
