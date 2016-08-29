require 'test_helper'

class MonedasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @moneda = monedas(:one)
  end

  test "should get index" do
    get monedas_url
    assert_response :success
  end

  test "should get new" do
    get new_moneda_url
    assert_response :success
  end

  test "should create moneda" do
    assert_difference('Moneda.count') do
      post monedas_url, params: { moneda: { descripcion: @moneda.descripcion, nombre: @moneda.nombre, simbolo: @moneda.simbolo, tipoDeCambio: @moneda.tipoDeCambio } }
    end

    assert_redirected_to moneda_url(Moneda.last)
  end

  test "should show moneda" do
    get moneda_url(@moneda)
    assert_response :success
  end

  test "should get edit" do
    get edit_moneda_url(@moneda)
    assert_response :success
  end

  test "should update moneda" do
    patch moneda_url(@moneda), params: { moneda: { descripcion: @moneda.descripcion, nombre: @moneda.nombre, simbolo: @moneda.simbolo, tipoDeCambio: @moneda.tipoDeCambio } }
    assert_redirected_to moneda_url(@moneda)
  end

  test "should destroy moneda" do
    assert_difference('Moneda.count', -1) do
      delete moneda_url(@moneda)
    end

    assert_redirected_to monedas_url
  end
end
