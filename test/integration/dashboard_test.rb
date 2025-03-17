require 'test_helper'

class DashboardTest < ActionDispatch::IntegrationTest
  test 'guests are redirected to the login page' do
    get dashboard_path

    assert_redirected_to login_path
  end

  test 'authenticated users can visit the dashboard' do
    user = FactoryBot.create(:user)

    acting_as(user).get dashboard_path

    assert_response :success
  end
end
