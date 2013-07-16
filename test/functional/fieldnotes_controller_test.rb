require 'test_helper'

class FieldnotesControllerTest < ActionController::TestCase
  setup do
    @fieldnote = fieldnotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fieldnotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fieldnote" do
    assert_difference('Fieldnote.count') do
      post :create, :fieldnote => @fieldnote.attributes
    end

    assert_redirected_to fieldnote_path(assigns(:fieldnote))
  end

  test "should show fieldnote" do
    get :show, :id => @fieldnote.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fieldnote.to_param
    assert_response :success
  end

  test "should update fieldnote" do
    put :update, :id => @fieldnote.to_param, :fieldnote => @fieldnote.attributes
    assert_redirected_to fieldnote_path(assigns(:fieldnote))
  end

  test "should destroy fieldnote" do
    assert_difference('Fieldnote.count', -1) do
      delete :destroy, :id => @fieldnote.to_param
    end

    assert_redirected_to fieldnotes_path
  end
end
