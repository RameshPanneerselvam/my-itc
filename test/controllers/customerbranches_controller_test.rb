require 'test_helper'

class CustomerbranchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customerbranch = customerbranches(:one)
  end

  test "should get index" do
    get customerbranches_url
    assert_response :success
  end

  test "should get new" do
    get new_customerbranch_url
    assert_response :success
  end

  test "should create customerbranch" do
    assert_difference('Customerbranch.count') do
      post customerbranches_url, params: { customerbranch: { customer_id: @customerbranch.customer_id, customer_name: @customerbranch.customer_name } }
    end

    assert_redirected_to customerbranch_url(Customerbranch.last)
  end

  test "should show customerbranch" do
    get customerbranch_url(@customerbranch)
    assert_response :success
  end

  test "should get edit" do
    get edit_customerbranch_url(@customerbranch)
    assert_response :success
  end

  test "should update customerbranch" do
    patch customerbranch_url(@customerbranch), params: { customerbranch: { customer_id: @customerbranch.customer_id, customer_name: @customerbranch.customer_name } }
    assert_redirected_to customerbranch_url(@customerbranch)
  end

  test "should destroy customerbranch" do
    assert_difference('Customerbranch.count', -1) do
      delete customerbranch_url(@customerbranch)
    end

    assert_redirected_to customerbranches_url
  end
end
