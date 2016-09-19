require 'test_helper'

class StockPedidosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_pedido = stock_pedidos(:one)
  end

  test "should get index" do
    get stock_pedidos_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_pedido_url
    assert_response :success
  end

  test "should create stock_pedido" do
    assert_difference('StockPedido.count') do
      post stock_pedidos_url, params: { stock_pedido: { cantidadTotal: @stock_pedido.cantidadTotal, precioTotal: @stock_pedido.precioTotal, vendedor: @stock_pedido.vendedor } }
    end

    assert_redirected_to stock_pedido_url(StockPedido.last)
  end

  test "should show stock_pedido" do
    get stock_pedido_url(@stock_pedido)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_pedido_url(@stock_pedido)
    assert_response :success
  end

  test "should update stock_pedido" do
    patch stock_pedido_url(@stock_pedido), params: { stock_pedido: { cantidadTotal: @stock_pedido.cantidadTotal, precioTotal: @stock_pedido.precioTotal, vendedor: @stock_pedido.vendedor } }
    assert_redirected_to stock_pedido_url(@stock_pedido)
  end

  test "should destroy stock_pedido" do
    assert_difference('StockPedido.count', -1) do
      delete stock_pedido_url(@stock_pedido)
    end

    assert_redirected_to stock_pedidos_url
  end
end
