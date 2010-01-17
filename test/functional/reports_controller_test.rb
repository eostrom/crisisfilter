require 'test_helper'

class ReportsControllerTest < ActionController::TestCase

  test "should create report" do
    Report.any_instance.expects(:save).returns(true)
    post :create, :report => { }
    assert_response :redirect
  end

  test "should handle failure to create report" do
    Report.any_instance.expects(:save).returns(false)
    post :create, :report => { }
    assert_template "new"
  end

  test "should destroy report" do
    Report.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => reports(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy report" do
    Report.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => reports(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for report" do
    get :edit, :id => reports(:one).to_param
    assert_response :success
  end

  test "should get index for reports" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get new for report" do
    get :new
    assert_response :success
  end

  test "should get show for report" do
    get :show, :id => reports(:one).to_param
    assert_response :success
  end

  test "should update report" do
    Report.any_instance.expects(:save).returns(true)
    put :update, :id => reports(:one).to_param, :report => { }
    assert_response :redirect
  end

  test "should handle failure to update report" do
    Report.any_instance.expects(:save).returns(false)
    put :update, :id => reports(:one).to_param, :report => { }
    assert_template "edit"
  end

end