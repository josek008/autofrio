# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#categories-table').dataTable
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
		sPaginationType: "full_numbers",
		iDisplayLength: 100