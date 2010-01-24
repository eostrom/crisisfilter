require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get index for reports" do
    Report.expects(:refresh_if_needed).returns(0)
    Factory.create(:report)

    get :index

    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get filter" do
    Factory.create(:report, :upvotes => 1)

    get :filter

    assert_response :success
    assert_not_nil assigns(:reports)
  end
end
