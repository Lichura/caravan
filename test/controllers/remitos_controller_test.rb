require 'test_helper'

class RemitosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @remito = remitos(:one)
  end

  test "should get index" do
    get remitos_url
    assert_response :success
  end

  test "should get new" do
    get new_remito_url
    assert_response :success
  end

  test "should create remito" do
    assert_difference('Remito.count') do
      post remitos_url, params: { remito: { cantidadTotal: @remito.cantidadTotal, fecha: @remito.fecha, ivaTotal: @remito.ivaTotal, numero: @remito.numero, pedido_id: @remito.pedido_id, total: @remito.total, transporte: @remito.transporte } }
    end

    assert_redirected_to remito_url(Remito.last)
  end

  test "should show remito" do
    get remito_url(@remito)
    assert_response :success
  end

  test "should get edit" do
    get edit_remito_url(@remito)
    assert_response :success
  end

  test "should update remito" do
    patch remito_url(@remito), params: { remito: { cantidadTotal: @remito.cantidadTotal, fecha: @remito.fecha, ivaTotal: @remito.ivaTotal, numero: @remito.numero, pedido_id: @remito.pedido_id, total: @remito.total, transporte: @remito.transporte } }
    assert_redirected_to remito_url(@remito)
  end

  test "should destroy remito" do
    assert_difference('Remito.count', -1) do
      delete remito_url(@remito)
    end

    assert_redirected_to remitos_url
  end
end
