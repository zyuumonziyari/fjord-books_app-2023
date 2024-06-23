# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    sign_in @user
  end

  test 'should get index' do
    get users_url
    assert_response :success
    assert_select 'nav.pagination'
  end

  test 'should get show' do
    get user_url(@user)
    assert_response :success
  end
end
