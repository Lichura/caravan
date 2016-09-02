# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	provincias = $('#ciudad_provincia_id').html()
	$('#ciudad_pais_id').change -> 
		pais = $('#ciudad_pais_id :selected').text()
		options = $(provincias).filter("optgroup[label='#{pais}']").html()
		if options
			$('#ciudad_provincia_id').html(options)
		else
			$('#ciudad_provincia_id').empty()