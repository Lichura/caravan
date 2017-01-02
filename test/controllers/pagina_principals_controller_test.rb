require 'test_helper'

class PaginaPrincipalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pagina_principal = pagina_principals(:one)
  end

  test "should get index" do
    get pagina_principals_url
    assert_response :success
  end

  test "should get new" do
    get new_pagina_principal_url
    assert_response :success
  end

  test "should create pagina_principal" do
    assert_difference('PaginaPrincipal.count') do
      post pagina_principals_url, params: { pagina_principal: { imagen_principal: @pagina_principal.imagen_principal, nosotros_texto: @pagina_principal.nosotros_texto } }
    end

    assert_redirected_to pagina_principal_url(PaginaPrincipal.last)
  end

  test "should show pagina_principal" do
    get pagina_principal_url(@pagina_principal)
    assert_response :success
  end

  test "should get edit" do
    get edit_pagina_principal_url(@pagina_principal)
    assert_response :success
  end

  test "should update pagina_principal" do
    patch pagina_principal_url(@pagina_principal), params: { pagina_principal: { imagen_principal: @pagina_principal.imagen_principal, nosotros_texto: @pagina_principal.nosotros_texto } }
    assert_redirected_to pagina_principal_url(@pagina_principal)
  end

  test "should destroy pagina_principal" do
    assert_difference('PaginaPrincipal.count', -1) do
      delete pagina_principal_url(@pagina_principal)
    end

    assert_redirected_to pagina_principals_url
  end
end
