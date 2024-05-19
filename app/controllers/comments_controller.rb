# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    if params[:report_id].present?
      commentable = Report.find(params[:report_id])
    elsif params[:book_id].present?
      commentable = Book.find(params[:book_id])
    end
    comment = commentable.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_to polymorphic_path(commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)    
    else
      redirect_to polymorphic_path(commentable), notice: t('controllers.common.notice_falese', name: Comment.model_name.human)    
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to polymorphic_path(@comment.commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  @comment.destroy
    redirect_to polymorphic_path(@comment.commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
