# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("a[data-brand]").click ->
		brand_id = $(this).data("brand")
		$('#filter_brand').val(brand_id)
		$('#filter_form').submit()