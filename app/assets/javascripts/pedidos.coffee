# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $(".producto_selection").on "change", ->
    $.ajax
      url: "/pedidos/get_precios"
      type: "GET"
      dataType: "script"
      data:
        producto_id: $('.producto_selection option:selected').val()



jQuery ->
	$(document).ready ->
  		$("#pedido_user_id").on "change", ->
  			$.ajax
  				url: "/pedidos/new"
  				type: "GET"
  				data:
  					cliente_id: $('#pedido_user_id option:selected').val()
  				success: (data) ->


jQuery ->
  $(document).ready ->
      $("#buscarAfip1").on "change", ->
        alert("cambio")