require 'test_helper'

class RegionalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regional = regionals(:one)
  end

  test "should get index" do
    get regionals_url
    assert_response :success
  end

  test "should get new" do
    get new_regional_url
    assert_response :success
  end

  test "should create regional" do
    assert_difference('Regional.count') do
      post regionals_url, params: { regional: { regional_name: @regional.regional_name } }
    end

    assert_redirected_to regional_url(Regional.last)
  end

  test "should show regional" do
    get regional_url(@regional)
    assert_response :success
  end

  test "should get edit" do
    get edit_regional_url(@regional)
    assert_response :success
  end

  test "should update regional" do
    patch regional_url(@regional), params: { regional: { regional_name: @regional.regional_name } }
    assert_redirected_to regional_url(@regional)
  end

  test "should destroy regional" do
    assert_difference('Regional.count', -1) do
      delete regional_url(@regional)
    end

    assert_redirected_to regionals_url
  end
end
