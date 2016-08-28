require 'test_helper'

class FamiliaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @familium = familia(:one)
  end

  test "should get index" do
    get familia_url
    assert_response :success
  end

  test "should get new" do
    get new_familium_url
    assert_response :success
  end

  test "should create familium" do
    assert_difference('Familium.count') do
      post familia_url, params: { familium: { descripcion: @familium.descripcion, nombre: @familium.nombre } }
    end

    assert_redirected_to familium_url(Familium.last)
  end

  test "should show familium" do
    get familium_url(@familium)
    assert_response :success
  end

  test "should get edit" do
    get edit_familium_url(@familium)
    assert_response :success
  end

  test "should update familium" do
    patch familium_url(@familium), params: { familium: { descripcion: @familium.descripcion, nombre: @familium.nombre } }
    assert_redirected_to familium_url(@familium)
  end

  test "should destroy familium" do
    assert_difference('Familium.count', -1) do
      delete familium_url(@familium)
    end

    assert_redirected_to familia_url
  end
end
