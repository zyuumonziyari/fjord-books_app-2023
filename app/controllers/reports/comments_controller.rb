# frozen_string_literal: true

module Reports
  class CommentsController < Comments::BaseController
    def render_commentable(comment)
      render 'reports/show', locals: { report: @commentable, comment: comment }, status: :unprocessable_entity  
    end

    private

    def set_commentable
      @commentable = Report.find(params[:report_id])
    end
  end
end
