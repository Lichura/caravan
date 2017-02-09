require 'test_helper'

class RangosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rango = rangos(:one)
  end

  test "should get index" do
    get rangos_url
    assert_response :success
  end

  test "should get new" do
    get new_rango_url
    assert_response :success
  end

  test "should create rango" do
    assert_difference('Rango.count') do
      post rangos_url, params: { rango: { digito: @rango.digito, letras: @rango.letras, numero: @rango.numero, pedido_id: @rango.pedido_id, user_id: @rango.user_id } }
    end

    assert_redirected_to rango_url(Rango.last)
  end

  test "should show rango" do
    get rango_url(@rango)
    assert_response :success
  end

  test "should get edit" do
    get edit_rango_url(@rango)
    assert_response :success
  end

  test "should update rango" do
    patch rango_url(@rango), params: { rango: { digito: @rango.digito, letras: @rango.letras, numero: @rango.numero, pedido_id: @rango.pedido_id, user_id: @rango.user_id } }
    assert_redirected_to rango_url(@rango)
  end

  test "should destroy rango" do
    assert_difference('Rango.count', -1) do
      delete rango_url(@rango)
    end

    assert_redirected_to rangos_url
  end
end
