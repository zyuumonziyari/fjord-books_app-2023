# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: %i[edit update destroy]

  def create
    if params[:report_id].present?
      commentable = Report.find(params[:report_id])
    elsif params[:book_id].present?
      commentable = Book.find(params[:book_id])
    end
    message = commentable.messages.build(message_params)
    message.user_id = current_user.id
    message.save
    redirect_to polymorphic_path(commentable), notice: t('controllers.common.notice_create', name: Message.model_name.human)
  end

  def edit; end

  def update
    if @message.update(message_params)
      redirect_to polymorphic_path(@message.commentable), notice: t('controllers.common.notice_update', name: Message.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  
  end

  def destroy
    @message.destroy
    redirect_to polymorphic_path(@message.commentable), notice: t('controllers.common.notice_destroy', name: Message.model_name.human)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
