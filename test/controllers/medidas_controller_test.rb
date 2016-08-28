require 'test_helper'

class MedidasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medida = medidas(:one)
  end

  test "should get index" do
    get medidas_url
    assert_response :success
  end

  test "should get new" do
    get new_medida_url
    assert_response :success
  end

  test "should create medida" do
    assert_difference('Medida.count') do
      post medidas_url, params: { medida: { abreviatura: @medida.abreviatura, codigoAfip: @medida.codigoAfip, descripcion: @medida.descripcion, nombre: @medida.nombre } }
    end

    assert_redirected_to medida_url(Medida.last)
  end

  test "should show medida" do
    get medida_url(@medida)
    assert_response :success
  end

  test "should get edit" do
    get edit_medida_url(@medida)
    assert_response :success
  end

  test "should update medida" do
    patch medida_url(@medida), params: { medida: { abreviatura: @medida.abreviatura, codigoAfip: @medida.codigoAfip, descripcion: @medida.descripcion, nombre: @medida.nombre } }
    assert_redirected_to medida_url(@medida)
  end

  test "should destroy medida" do
    assert_difference('Medida.count', -1) do
      delete medida_url(@medida)
    end

    assert_redirected_to medidas_url
  end
end
