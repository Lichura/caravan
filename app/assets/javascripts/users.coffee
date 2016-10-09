# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	$('form').on 'click', '.remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('fieldset').hide()
		event.preventDefault()

jQuery ->
	$('.add_fields').on 'click', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()



jQuery ->
	ciudades = $('#user_localidad_id').html()
	$('#user_provincia_id').on "change", -> 
		provincia = $('#user_provincia_id :selected').text()
		options = $(ciudades).filter("optgroup[label='#{provincia}']").html()
		if options
			$('#user_localidad_id').html(options)
		else
			$('#user_localidad_id').empty()


jQuery ->
	$(document).ready ->
  		$("#buscarAfip").on "change", ->
  			$.ajax
  				url: "/users/new"
  				type: "GET"
  				dataType: "script"
  				data:
  					search_afip: $('#buscarAfip').val()

jQuery ->
	$(document).ready ->
  			$.ajax
  				url: "/users/new"
  				type: "GET"
  				dataType: "script"
  				data:
  					search_afip: $('#buscarAfip').val()

