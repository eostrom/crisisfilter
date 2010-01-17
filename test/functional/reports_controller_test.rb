require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_report
    assert_difference('Report.count') do
      post :create, :report => { }
    end

    assert_redirected_to report_path(assigns(:report))
  end

  def test_should_show_report
    get :show, :id => reports(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => reports(:one).id
    assert_response :success
  end

  def test_should_update_report
    put :update, :id => reports(:one).id, :report => { }
    assert_redirected_to report_path(assigns(:report))
  end

  def test_should_destroy_report
    assert_difference('Report.count', -1) do
      delete :destroy, :id => reports(:one).id
    end

    assert_redirected_to reports_path
  end
end
