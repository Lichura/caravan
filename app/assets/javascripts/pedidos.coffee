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