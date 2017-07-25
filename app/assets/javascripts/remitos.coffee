# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	$(document).ready ->
  		$("#remito_transporte").on "change", ->
  			$.ajax
  				url: "/remitos/new"
  				type: "GET"
  				dataType: "script"
  				data:
  					transporte: $('#remito_transporte option:selected').text()
  				success: (data) ->

#jQuery ->
#	$(document).ready ->
# 			$.ajax
#  				url: "/remitos/new"
# 				type: "GET"
#  				dataType: "script"
#  				data:
#  					transporte: $('#remito_transporte option:selected').text()
#  				success: (data) ->