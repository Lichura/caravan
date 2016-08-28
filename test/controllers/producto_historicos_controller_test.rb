require 'test_helper'

class ProductoHistoricosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producto_historico = producto_historicos(:one)
  end

  test "should get index" do
    get producto_historicos_url
    assert_response :success
  end

  test "should get new" do
    get new_producto_historico_url
    assert_response :success
  end

  test "should create producto_historico" do
    assert_difference('ProductoHistorico.count') do
      post producto_historicos_url, params: { producto_historico: { fechaDesde: @producto_historico.fechaDesde, fechaHasta: @producto_historico.fechaHasta, precio: @producto_historico.precio, producto_id: @producto_historico.producto_id } }
    end

    assert_redirected_to producto_historico_url(ProductoHistorico.last)
  end

  test "should show producto_historico" do
    get producto_historico_url(@producto_historico)
    assert_response :success
  end

  test "should get edit" do
    get edit_producto_historico_url(@producto_historico)
    assert_response :success
  end

  test "should update producto_historico" do
    patch producto_historico_url(@producto_historico), params: { producto_historico: { fechaDesde: @producto_historico.fechaDesde, fechaHasta: @producto_historico.fechaHasta, precio: @producto_historico.precio, producto_id: @producto_historico.producto_id } }
    assert_redirected_to producto_historico_url(@producto_historico)
  end

  test "should destroy producto_historico" do
    assert_difference('ProductoHistorico.count', -1) do
      delete producto_historico_url(@producto_historico)
    end

    assert_redirected_to producto_historicos_url
  end
end
