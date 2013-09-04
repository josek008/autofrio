# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#search-table').dataTable
		aaSorting: [[0,'asc'], [1,'asc'], [2,'asc'], [3,'asc'] ]
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
		sDom: "tipr"