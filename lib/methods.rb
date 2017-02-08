module metodos

	def convertir_letras_a_numeros(letras)
		numeros = hash.new
		for letra in letras
			numeros << constants.letras_a_numeros_afip[letra]
		end
	end

	def asociar_array_letras_y_numeros(letras,numeros)
		nuevo_array = letras + numeros
	end

	def multiplicar_por_secuencia(array_de_letras_y_numeros)
		constants.secuencia_afip
	end

	def sumar_numeros_multiplicados(array_numeros_multiplicados)
		array_numeros_multiplicados.all.sum
	end

	def divison_de_la_suma(numero)
		numero % 11
	end

	def calcular_digito_verificador(numero)
		switch numero
			case 0: 0
			case 1: 1
			default: 11 - numero
		end
	end

end