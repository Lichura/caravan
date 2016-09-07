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
  		$("#pedido_pedido_cuit").on "change", ->
  			$.ajax
  				url: "/pedidos/get_cliente"
  				type: "GET"
  				dataType: "json"
  				data:
  					cliente_id: $('#pedido_pedido_cuit option:selected').val()
  				success: (data) ->
        			$('#clienteCuit').html(data.cuit)
        			$('#clienteRazonSocial').html(data.razonSocial)
        			$('#clienteCuig').html(data.cuig)
        			$('#clienteRenspa').html(data.renspa)
        			$('#clienteCV').html(data.numeroCv)
        			$('#clienteProvincia').html(data.provincia_id)
        			$('#clienteLocalidad').html(data.localidad_id)
        			$('#clienteCodigoPostal').html(data.codigoPostal)
        			$('#clienteDireccion').html(data.direccion)
        			$('#clienteTelefono').html(data.telefono)
        			$('#clienteEncargado').html(data.encargado)
        			$('#clienteSucursal').html(data.sucursal.last.nombre)
