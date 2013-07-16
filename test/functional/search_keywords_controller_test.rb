require 'test_helper'

class SearchKeywordsControllerTest < ActionController::TestCase
  setup do
    @search_keyword = search_keywords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_keywords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_keyword" do
    assert_difference('SearchKeyword.count') do
      post :create, :search_keyword => @search_keyword.attributes
    end

    assert_redirected_to search_keyword_path(assigns(:search_keyword))
  end

  test "should show search_keyword" do
    get :show, :id => @search_keyword.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @search_keyword.to_param
    assert_response :success
  end

  test "should update search_keyword" do
    put :update, :id => @search_keyword.to_param, :search_keyword => @search_keyword.attributes
    assert_redirected_to search_keyword_path(assigns(:search_keyword))
  end

  test "should destroy search_keyword" do
    assert_difference('SearchKeyword.count', -1) do
      delete :destroy, :id => @search_keyword.to_param
    end

    assert_redirected_to search_keywords_path
  end
end
