require 'test_helper'

class UsertypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usertype = usertypes(:one)
  end

  test "should get index" do
    get usertypes_url
    assert_response :success
  end

  test "should get new" do
    get new_usertype_url
    assert_response :success
  end

  test "should create usertype" do
    assert_difference('Usertype.count') do
      post usertypes_url, params: { usertype: { description: @usertype.description, isactive: @usertype.isactive, office_id: @usertype.office_id, type_name: @usertype.type_name } }
    end

    assert_redirected_to usertype_url(Usertype.last)
  end

  test "should show usertype" do
    get usertype_url(@usertype)
    assert_response :success
  end

  test "should get edit" do
    get edit_usertype_url(@usertype)
    assert_response :success
  end

  test "should update usertype" do
    patch usertype_url(@usertype), params: { usertype: { description: @usertype.description, isactive: @usertype.isactive, office_id: @usertype.office_id, type_name: @usertype.type_name } }
    assert_redirected_to usertype_url(@usertype)
  end

  test "should destroy usertype" do
    assert_difference('Usertype.count', -1) do
      delete usertype_url(@usertype)
    end

    assert_redirected_to usertypes_url
  end
end
