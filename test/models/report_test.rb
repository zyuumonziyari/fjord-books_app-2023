# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report_one = reports(:one)
    @report = Report.create(title: 'New Mention',
                            content: "http://localhost:3000/reports/#{@report_one.id}, http://localhost:3000/reports/#{@report_one.id}",
                            user: users(:two))
  end

  test 'should be valid' do
    assert @report.valid?
  end

  test 'should require a title' do
    @report.title = nil
    assert_not @report.valid?
  end

  test 'should require a content' do
    @report.content = nil
    assert_not @report.valid?
  end

  test '#editable?' do
    assert_equal users(:one), @report_one.user
  end

  test '#created_on' do
    expected_date = Time.zone.today.strftime('%Y/%m/%d')
    assert_equal expected_date, @report.created_on.strftime('%Y/%m/%d')
  end

  test '#save_mentions' do
    assert_equal 1, @report.mentioning_reports.count
  
    assert_equal @report_one, @report.mentioning_reports.first
  end
end
