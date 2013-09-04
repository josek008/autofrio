$('#showcase').carousel()

$ ->
	$("a[data-category]").click ->
		category_id = $(this).data("category")
		$('#category_id').val(category_id)
		$('#filter_form').submit()

$ ->
	$("a[data-brand]").click ->
		brand_id = $(this).data("brand")
		$('#brand_id').val(brand_id)
		$('#filter_form').submit()

$ ->
	$("a[data-line]").click ->
		line_id = $(this).data("line")
		$('#line_id').val(line_id)
		$('#filter_form').submit()