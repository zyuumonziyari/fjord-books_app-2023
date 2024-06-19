# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'should display correct user name or email' do
    user = User.new(name: '', email: 'foo@example.com')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'soichiro'
    assert_equal 'soichiro', user.name_or_email
  end
end
