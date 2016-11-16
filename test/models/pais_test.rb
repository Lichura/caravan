require 'test_helper'

class PaisTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

  test "prueba_fallida" do
    assert true
  end

  test "crear pais" do
  	pais = Pais.new({nombre: 'Argentina', abreviacion: 'AR'})
  	assert_equal(pais.nombre, 'Argentina')
  end

  test "crear pais con otro nombre" do
    pais1 = Pais.new({nombre: 'Argentina', abreviacion: 'AR'})
    assert_not_equal(pais1.nombre, 'Peru')
  end

  test "crear pais sin nombre" do
    pais1 = Pais.new({ abreviacion: 'AR'})
    assert_not pais1.save
  end

  test "crear pais sin abreviacion" do
    pais1 = Pais.new({ nombre: 'AR'})
    assert_not pais1.save
  end

  test "crear pais sin datos" do
    pais1 = Pais.new({})
    assert_not pais1.save
  end

  test "crear pais con el mismo nombre" do
    pais1 = Pais.new({ nombre: 'españa'})
    assert_not pais1.save
  end

  test "crear pais con la misma abreviacion" do
    pais1 = Pais.new({ abreviacion: 'ES'})
    assert_not pais1.save
  end
end

