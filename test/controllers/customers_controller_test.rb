require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_index_url
    assert_response :success
  end

  test "should get menu" do
    get customers_menu_url
    assert_response :success
  end

  test "should get checkout" do
    get customers_checkout_url
    assert_response :success
  end

  test "should get confirmation" do
    get customers_confirmation_url
    assert_response :success
  end
end
