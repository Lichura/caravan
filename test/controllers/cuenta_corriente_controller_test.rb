require 'test_helper'

class CuentaCorrienteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cuenta_corriente_index_url
    assert_response :success
  end

end
