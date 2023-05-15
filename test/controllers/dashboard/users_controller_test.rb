require 'test_helper'

class Dashboard::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get withdrawal' do
    get dashboard_users_withdrawal_url
    assert_response :success
  end
end
