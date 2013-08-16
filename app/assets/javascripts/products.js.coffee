# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("a[data-category]").click ->
		category_id = $(this).data("category")
		$('#filter_category').val(category_id)
		$('#filter_form').submit()

$ ->
	$("a[data-brand]").click ->
		brand_id = $(this).data("brand")
		$('#filter_brand').val(brand_id)
		$('#filter_form').submit()

$ ->
	$("a[data-line]").click ->
		line_id = $(this).data("line")
		$('#filter_line').val(line_id)
		$('#filter_form').submit()

jQuery ->
	$('#products-table').dataTable
		aaSorting: [ [2,'asc'], [1,'asc'], [0,'asc'] ]
		oLanguage:
			sProcessing: "Procesando..."
			sLengthMenu: "Mostrar _MENU_ registros"
			sZeroRecords: "No se encontraron resultados"
			sEmptyTable: "Ningún dato disponible en esta tabla"
			sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros"
			sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros"
			sInfoFiltered: "(filtrado de un total de _MAX_ registros)"
			sInfoPostFix: ""
			sSearch: "Buscar:"
			sUrl: ""
			oPaginate:
				sFirst: "Primero"
				sPrevious: "Anterior"
				sNext: "Siguiente"
				sLast: "Último"

		bPaginate: true,
		sPaginationType: "bootstrap",
		iDisplayLength: 100