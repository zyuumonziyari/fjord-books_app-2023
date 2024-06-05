# frozen_string_literal: true

class Comments::BaseController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  def create
    comment = @commentable.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_false', name: Comment.model_name.human)
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def set_commentable
    raise NotImplementedError, "#{self.class} must implement the set_commentable method"
  end
end
