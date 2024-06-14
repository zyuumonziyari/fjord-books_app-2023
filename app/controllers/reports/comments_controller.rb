# frozen_string_literal: true

module Reports
  class CommentsController < Comments::BaseController
    def render_commentable
      render 'reports/show', status: :unprocessable_entity
    end

    private

    def set_commentable
      @commentable = Report.find(params[:report_id])
    end
  end
end
