require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get account' do
    get dashboards_account_url
    assert_response :success
  end
end
