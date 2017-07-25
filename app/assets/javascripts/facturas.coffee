# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(document).ready ->
  		$("#traer_remitos").on "click", ->
  			$.ajax
  				url: "/facturas/new"
  				type: "GET"
  				success: (data) ->
  					alert("prueba")



