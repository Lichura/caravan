module Metodo

	LETRAS = {
  	a: '65', b: '66', c: '67', d: '68', e: '69', f: '70',
  	g: '71', h: '72', i: '73', j: '74', k: '75', l: '76',
  	m: '77', n: '78', o: '79', p: '80', q: '81', r: '82',
  	s: '83', t: '84', u: '85', v: '86', w: '87', x: '88',
  	y: '89', z: '90',
  	A:'65', B: '66', C: '67', D: '68', E: '69', F: '70',
  	G: '71', H: '72', I: '73', J: '74', K: '75', L: '76',
  	M: '77', N: '78', O: '79', P: '80', Q: '81', R: '82',
  	S: '83', T: '84', U: '85', V: '86', W: '87', X: '88',
  	Y: '89', Z: '90'
  	}

  	SECUENCIA = ['7', '6', '5', '4', '3', '2', '7', '6', '5', '4', '3', '2']

  	def calcular(cuig, caravana)
  		array_cuig = convertir_letras_a_numeros(cuig)
    	array_caravana = convertir_letras_a_numeros(caravana)
      	array_sumado =  array_cuig + array_caravana
    	texto = array_sumado.join('')
    	final = convertir_en_array(texto)
    	final = multiplicar_por_secuencia(final)
    	final = sumar_numeros_multiplicados(final)
    	final = divison_de_la_suma(final)
    	final = calcular_digito_verificador(final)
  	end


	def convertir_letras_a_numeros(letras)
		numeros = Array.new
		letras.each_char do |letra|
			if LETRAS[letra.to_sym]
				numeros << LETRAS[letra.to_sym] 
			else 
				numeros << letra
			end
		end
		return numeros
	end

	def convertir_en_array(texto)
		array_nuevo = Array.new
		texto.each_char do |letra|
			array_nuevo << letra
		end
		array_nuevo
	end
	def asociar_array_letras_y_numeros(letras,numeros)
		nuevo_array = letras + numeros
	end

	def multiplicar_por_secuencia(array)
		nuevo_array = Array.new
		for index in 0 ... array.size
			nuevo_array << array[index].to_i * SECUENCIA[index].to_i
		end
		nuevo_array
	end

	def sumar_numeros_multiplicados(array_numeros_multiplicados)
		array_numeros_multiplicados.inject(0, &:+) 
	end

	def divison_de_la_suma(numero)
		numero % 11
	end

	def calcular_digito_verificador(numero)
		case numero
			when 0
				0
			when 1
			 1
			else
			 11 - numero
		end
	end


	def descomponer_rango(rango)
		array_nuevo = Array.new
		array_nuevo = rango.split("")
		numero = /\d+/.match(rango).try(:[], 0)
		puts array_nuevo[0]
		case numero.size
		when 3
			aumentar_array_3_numeros(array_nuevo)
		when 2
			aumentar_array_2_numeros(array_nuevo)
		when 1
			aumentar_array_1_numero(array_nuevo)
		end
		return array_nuevo
	end

	def aumentar_array_3_numeros(array)
		if array[3].to_i < 9
			array[3] = array[3].next
		else
			array[3] = 0
			if array[2].to_i < 9
				array[2] = array[2].next
			else
				array[2] = 0
				if array[1].to_i < 9
					array[1] = array[1].next
				else
					if array[0] == "Z"
						array[1] = "A"
						array[0] = "A"
					else
						array[1]= 0
						array[0] = array[0].next
					end
				end
			end
		end	
		puts(array)
	end

	def aumentar_array_2_numeros(array)
		if array[3].to_i < 9
			array[3] = array[3].next
		else
			array[3] = 0
			if array[2].to_i < 9
				array[2] = array[2].next
			else
				if array[0] == "Z" && array[1] == "Z"
					array[0] = "A"
					array[1] = "A"
					array[2] = "A"
				else
					array[2] = 0
						if array[1] == "Z"
							array[0] = array[0].next
							array[1] = "A"
						else
							array[1] = array[1].next 
						end
				end
			end
		end	
		puts(array)
	end

	def aumentar_array_1_numero(array)
		if array[3].to_i < 9
			array[3] = array[3].next
		else
			array[3] = 0
			if array[0] == "Z" && array[1] == "Z" && array [2] == "Z"
				array[0] = "A"
				array[1] = 0
				array[2] = 0
			else
				if array[2] = "Z"
					array[2] = "A"
				else
					array[2] = array[2].next
					if array[1] = "Z"
						array[0] = array[0].next
						array[1] = "A"
					else
						array[1] = array[1].next 
					end
				end
			end
		end	
		puts(array)
	end


end