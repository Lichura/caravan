require 'test_helper'

class CondicionPagosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @condicion_pago = condicion_pagos(:one)
  end

  test "should get index" do
    get condicion_pagos_url
    assert_response :success
  end

  test "should get new" do
    get new_condicion_pago_url
    assert_response :success
  end

  test "should create condicion_pago" do
    assert_difference('CondicionPago.count') do
      post condicion_pagos_url, params: { condicion_pago: { descripcion: @condicion_pago.descripcion, dias: @condicion_pago.dias, nombre: @condicion_pago.nombre, user_id: @condicion_pago.user_id } }
    end

    assert_redirected_to condicion_pago_url(CondicionPago.last)
  end

  test "should show condicion_pago" do
    get condicion_pago_url(@condicion_pago)
    assert_response :success
  end

  test "should get edit" do
    get edit_condicion_pago_url(@condicion_pago)
    assert_response :success
  end

  test "should update condicion_pago" do
    patch condicion_pago_url(@condicion_pago), params: { condicion_pago: { descripcion: @condicion_pago.descripcion, dias: @condicion_pago.dias, nombre: @condicion_pago.nombre, user_id: @condicion_pago.user_id } }
    assert_redirected_to condicion_pago_url(@condicion_pago)
  end

  test "should destroy condicion_pago" do
    assert_difference('CondicionPago.count', -1) do
      delete condicion_pago_url(@condicion_pago)
    end

    assert_redirected_to condicion_pagos_url
  end
end
