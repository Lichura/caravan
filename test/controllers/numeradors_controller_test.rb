require 'test_helper'

class NumeradorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @numerador = numeradors(:one)
  end

  test "should get index" do
    get numeradors_url
    assert_response :success
  end

  test "should get new" do
    get new_numerador_url
    assert_response :success
  end

  test "should create numerador" do
    assert_difference('Numerador.count') do
      post numeradors_url, params: { numerador: { comprobante: @numerador.comprobante, numero: @numerador.numero, puntoDeVenta: @numerador.puntoDeVenta } }
    end

    assert_redirected_to numerador_url(Numerador.last)
  end

  test "should show numerador" do
    get numerador_url(@numerador)
    assert_response :success
  end

  test "should get edit" do
    get edit_numerador_url(@numerador)
    assert_response :success
  end

  test "should update numerador" do
    patch numerador_url(@numerador), params: { numerador: { comprobante: @numerador.comprobante, numero: @numerador.numero, puntoDeVenta: @numerador.puntoDeVenta } }
    assert_redirected_to numerador_url(@numerador)
  end

  test "should destroy numerador" do
    assert_difference('Numerador.count', -1) do
      delete numerador_url(@numerador)
    end

    assert_redirected_to numeradors_url
  end
end
