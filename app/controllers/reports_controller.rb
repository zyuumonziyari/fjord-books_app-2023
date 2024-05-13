# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  MENTION_PATH = /http:\/\/\[::1\]:3000\/reports\/(\d+)/

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      mentioned_ids = scan_mentioned_ids(params[:report][:content])
      report_id = @report.id
      manage_mention(report_id, mentioned_ids) if mentioned_ids.present?
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      mentioned_ids = scan_mentioned_ids(params[:report][:content])
      report_id = @report.id
      manage_mention(report_id, mentioned_ids)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def scan_mentioned_ids(content)
    content.scan(MENTION_PATH).flatten.map(&:to_i)
  end

  def manage_mention(report_id, mentioned_ids)
    existing_mentioned_ids = MentionReport.where(mentioning_reports_id: report_id).pluck(:mentioned_reports_id)
    unwanted_mentioned_ids = existing_mentioned_ids - mentioned_ids
    wanted_mentioned_ids = mentioned_ids - existing_mentioned_ids

    create_mention(report_id, wanted_mentioned_ids) if wanted_mentioned_ids.present?
    destroy_mention(report_id, unwanted_mentioned_ids) if unwanted_mentioned_ids.present?
  end

  def create_mention(report_id, mentioned_ids)
    mentioned_ids.each do |mentioned_id|
      MentionReport.create(mentioned_reports_id: mentioned_id, mentioning_reports_id: report_id)
    end
  end
    
  def destroy_mention(report_id, unwanted_mentioned_ids)
    MentionReport.where(mentioning_reports_id: report_id, mentioned_reports_id: unwanted_mentioned_ids).destroy_all
  end
end
