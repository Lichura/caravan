require 'test_helper'

class NotaCreditosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nota_credito = nota_creditos(:one)
  end

  test "should get index" do
    get nota_creditos_url
    assert_response :success
  end

  test "should get new" do
    get new_nota_credito_url
    assert_response :success
  end

  test "should create nota_credito" do
    assert_difference('NotaCredito.count') do
      post nota_creditos_url, params: { nota_credito: { cliente_id: @nota_credito.cliente_id, distribuidor_id: @nota_credito.distribuidor_id, estado: @nota_credito.estado, factura_id: @nota_credito.factura_id, fecha: @nota_credito.fecha, iva: @nota_credito.iva, neto: @nota_credito.neto, tipo: @nota_credito.tipo, total: @nota_credito.total, vendedor_id: @nota_credito.vendedor_id } }
    end

    assert_redirected_to nota_credito_url(NotaCredito.last)
  end

  test "should show nota_credito" do
    get nota_credito_url(@nota_credito)
    assert_response :success
  end

  test "should get edit" do
    get edit_nota_credito_url(@nota_credito)
    assert_response :success
  end

  test "should update nota_credito" do
    patch nota_credito_url(@nota_credito), params: { nota_credito: { cliente_id: @nota_credito.cliente_id, distribuidor_id: @nota_credito.distribuidor_id, estado: @nota_credito.estado, factura_id: @nota_credito.factura_id, fecha: @nota_credito.fecha, iva: @nota_credito.iva, neto: @nota_credito.neto, tipo: @nota_credito.tipo, total: @nota_credito.total, vendedor_id: @nota_credito.vendedor_id } }
    assert_redirected_to nota_credito_url(@nota_credito)
  end

  test "should destroy nota_credito" do
    assert_difference('NotaCredito.count', -1) do
      delete nota_credito_url(@nota_credito)
    end

    assert_redirected_to nota_creditos_url
  end
end
