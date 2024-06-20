# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report_one = reports(:one)
    @report_two = reports(:two)
  end

  test 'should be same target_user as user' do
    assert_equal users(:one), @report_one.user
  end

  test 'should be correct date' do
    report = Report.create(title: 'Hi!', content: 'My name is one!', user: users(:one))
    expected_date = report.created_on.strftime('%Y/%m/%d')
    assert_equal '2024/06/20', expected_date
  end

  test 'should have correct active mentions' do
    assert_equal 1, @report_one.active_mentions.count
    assert_equal @report_two, @report_one.active_mentions.first.mentioned_by
  end

  test 'should have correct mentioning reports' do
    assert_equal 1, @report_one.mentioning_reports.count
    assert_equal @report_two, @report_one.mentioning_reports.first
  end

  test 'should have correct passive mentions' do
    assert_equal 1, @report_one.passive_mentions.count
    assert_equal @report_two, @report_one.passive_mentions.first.mention_to
  end

  test 'should have correct mentioned reports' do
    assert_equal 1, @report_one.mentioned_reports.count
    assert_equal @report_two, @report_one.mentioned_reports.first
  end

  test 'should save mentions after save' do
    new_report = Report.create(title: 'New Mention', content: "http://localhost:3000/reports/#{@report_two.id}", user: users(:three))
    assert_equal @report_two, new_report.mentioning_reports.first
  end
end
