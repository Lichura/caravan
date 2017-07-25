$('document').ready(function(){



	 $('.subtotal').change(function() {
    	UpdateTotal();
    });

	$(".precio-unitario").change(function(){
		calcularPrecioArticulo(this);
		cambiarImagenInsumo(this);
		deseleccionarChecks(this);
	});
	
	$(".precio-unitario").each(function(){
		calcularPrecioArticulo(this);

	});

	$('.cantidad').off('change').on('change', function() {
        UpdateSubTotal(this);
        validarArticulos(this);
        
    });



  function agregarTilde(elem){
  	 $(elem).append("<i style='color:green' class='glyphicon glyphicon-ok'></i>");
  }

function UpdateSubTotal(elem) {
    // This will give the tr of the Element Which was changed
    var $container = $(elem).parent().parent();
    var quantity = $container.find('.cantidad').val();
    var price = $container.find('.precio').val();
    var subtotal = parseInt(quantity) * parseFloat(price);
    $container.find('.subtotal').text(subtotal.toFixed(2)).trigger('change');
}

 function UpdateTotal() {
	var sum = 0;
	var cantidad = 0;
	$(".subtotal").each(function() {
	    var val = $.trim( $(this).text() );
	    if ( val ) {
	        val = parseFloat( val.replace( /^\$/, "" ) );
	        sum += !isNaN( val ) ? val : 0;
	    }
	});

	$(".cantidad").each(function(){
		var val = $.trim( $(this).val() );
		cantidad += parseFloat(val);
	});

	$("input.total").val( sum );
	$("input.cantidadTotal").val( cantidad );
}

function calcularPrecioArticulo(elem) {
	var suma = 0;
	var $container = $(elem).parent().parent().parent();
	var $elemento = $(elem).parent().parent();
	$elemento.find('.detalle-producto-informacion-insumo').each(function() {
			if ($(this).find('.precio-unitario').find('input[type=checkbox]').prop('checked') == true){
			var val = $(this).find('.precio-unitario').attr("value");
			   	if ( val ) {
			        val = parseFloat( val.replace( /^\$/, "" ) );
			        suma += !isNaN( val ) ? val : 0;
			    }
		}
	});
	var cantidad = $container.find('.cantidad').val();
	var subtotal = parseInt(cantidad) * parseFloat(suma);
	$container.find('.precio').text(suma.toFixed(2)).trigger('change');
	$container.find('.subtotal').text(subtotal.toFixed(2)).trigger('change');
}

  function cambiarImagenInsumo(elem){
  	var $container = $(elem).parent().parent().parent();
  	var $imagen = $container.find('.producto_imagen');
  	var $elemento = $(elem).parent();
  	var nueva_imagen = $elemento.find('.insumo_imagen').attr("name");
  	$imagen.attr("src", nueva_imagen);
  	
  }

  function deseleccionarChecks(elem){
  	var $container = $(elem).parent().parent().parent();
	var $elemento = $(elem).parent().parent();
	var $checkbox = $(elem).find(".checkbox_insumo").attr("id");
  	$elemento.find(".checkbox_insumo").each(function(){
  		if ($(this).attr("id") != $checkbox ){
  			$(this).attr('checked', false);
  	}
  	});
  }

  function validarArticulos(elem){
  	var $container = $(elem).parent().parent().parent();
	var $elemento = $(elem).parent().parent().parent();
	var quantity = $(elem).val();
	var chequeado = false
	if (quantity > 0){
  		$elemento.find(".checkbox_insumo").each(function(){
  			if ( $(this).is(':checked') ){
  				chequeado = true;
  				alert("prueba");
  			}
  		});
  	}
  	if (chequeado === false){
  		alert("No seleccionaste ninguna opcion.");
  	}
  }
});