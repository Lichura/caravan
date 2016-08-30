require 'test_helper'

class TransportistaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transportistum = transportista(:one)
  end

  test "should get index" do
    get transportista_url
    assert_response :success
  end

  test "should get new" do
    get new_transportistum_url
    assert_response :success
  end

  test "should create transportistum" do
    assert_difference('Transportistum.count') do
      post transportista_url, params: { transportistum: { comentarios: @transportistum.comentarios, cuit: @transportistum.cuit, destino: @transportistum.destino, dni: @transportistum.dni, dniRetira: @transportistum.dniRetira, nombre: @transportistum.nombre, numeroGuia: @transportistum.numeroGuia } }
    end

    assert_redirected_to transportistum_url(Transportistum.last)
  end

  test "should show transportistum" do
    get transportistum_url(@transportistum)
    assert_response :success
  end

  test "should get edit" do
    get edit_transportistum_url(@transportistum)
    assert_response :success
  end

  test "should update transportistum" do
    patch transportistum_url(@transportistum), params: { transportistum: { comentarios: @transportistum.comentarios, cuit: @transportistum.cuit, destino: @transportistum.destino, dni: @transportistum.dni, dniRetira: @transportistum.dniRetira, nombre: @transportistum.nombre, numeroGuia: @transportistum.numeroGuia } }
    assert_redirected_to transportistum_url(@transportistum)
  end

  test "should destroy transportistum" do
    assert_difference('Transportistum.count', -1) do
      delete transportistum_url(@transportistum)
    end

    assert_redirected_to transportista_url
  end
end
