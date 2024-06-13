# frozen_string_literal: true

module Reports
  class CommentsController < Comments::BaseController
    def create
      comment = @commentable.comments.build(comment_params)
      comment.user_id = current_user.id
      if comment.save
        redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        render 'reports/show', locals: { report: @commentable, comment: comment }, status: :unprocessable_entity  
      end
    end

    private

    def set_commentable
      @commentable = Report.find(params[:report_id])
    end
  end
end
