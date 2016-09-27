require 'test_helper'

class PaisTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

  test "prueba_fallida" do
    assert false
  end

  test "crear pais" do
  	user = Pais.new({nombre: 'Argentina', abreviacion: 'AR'})
  	assert_equal(pais.nombre, 'Argentina')
  end
end
