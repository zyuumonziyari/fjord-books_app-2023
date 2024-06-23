# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @report_one = reports(:one)
    @report_two = reports(:two)
    @user = users(:one)

    sign_in @user
  end

  test 'should get index' do
    get reports_url
    assert_response :success
    assert_select 'nav.pagination'
  end

  test 'should get new' do
    get new_report_url
    assert_response :success
  end

  test 'should create report' do
    assert_difference('Report.count') do
      post reports_url, params: {
        report: {
          content: @report_one.content,
          title: @report_one.title,
          user: @report_one.user
        }
      }
    end

    assert_redirected_to report_url(Report.last)
    assert_equal '日報が作成されました。', flash[:notice]
  end

  test 'should not create report with invalid data' do
    assert_no_difference('Report.count') do
      post reports_url, params: { report: { title: nil, memo: nil, user: nil } }
    end

    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should show report' do
    get report_url(@report_one)
    assert_response :success
  end

  test 'should get edit' do
    get edit_report_url(@report_one)
    assert_response :success
  end

  test 'should update report' do
    patch report_url(@report_one), params: {
      report: {
        content: @report_two.content,
        title: @report_two.title
      }
    }

    assert_redirected_to report_url(@report_one)
    assert_equal '日報が更新されました。', flash[:notice]

    @report_one.reload
    assert_equal 'MyText2', @report_one.content
    assert_equal 'MyString2', @report_one.title
  end

  test 'should not update report with invalid data' do
    assert_no_difference('Report.count') do
      patch report_url(@report_one), params: { report: { title: nil, memo: nil, user: nil } }
    end

    assert_response :unprocessable_entity
    assert_template :edit
  end

  test 'should destroy report' do
    assert_difference('Report.count', -1) do
      delete report_url(@report_one)
    end

    assert_redirected_to reports_url
    assert_equal '日報が削除されました。', flash[:notice]
  end
end
