require 'test_helper'

class PagemastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pagemaster = pagemasters(:one)
  end

  test "should get index" do
    get pagemasters_url
    assert_response :success
  end

  test "should get new" do
    get new_pagemaster_url
    assert_response :success
  end

  test "should create pagemaster" do
    assert_difference('Pagemaster.count') do
      post pagemasters_url, params: { pagemaster: { page_name: @pagemaster.page_name, page_url: @pagemaster.page_url, parent_id: @pagemaster.parent_id, type_of_page: @pagemaster.type_of_page } }
    end

    assert_redirected_to pagemaster_url(Pagemaster.last)
  end

  test "should show pagemaster" do
    get pagemaster_url(@pagemaster)
    assert_response :success
  end

  test "should get edit" do
    get edit_pagemaster_url(@pagemaster)
    assert_response :success
  end

  test "should update pagemaster" do
    patch pagemaster_url(@pagemaster), params: { pagemaster: { page_name: @pagemaster.page_name, page_url: @pagemaster.page_url, parent_id: @pagemaster.parent_id, type_of_page: @pagemaster.type_of_page } }
    assert_redirected_to pagemaster_url(@pagemaster)
  end

  test "should destroy pagemaster" do
    assert_difference('Pagemaster.count', -1) do
      delete pagemaster_url(@pagemaster)
    end

    assert_redirected_to pagemasters_url
  end
end
