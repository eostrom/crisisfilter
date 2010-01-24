require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get index for reports" do
    Report.expects(:refresh_if_needed).returns(0)
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end
end
