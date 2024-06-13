# frozen_string_literal: true

module Books
  class CommentsController < Comments::BaseController
    def create
      comment = @commentable.comments.build(comment_params)
      comment.user_id = current_user.id
      if comment.save
        redirect_to polymorphic_path(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        render 'books/show', locals: { book: @commentable, comment: comment }, status: :unprocessable_entity  
      end
    end

    private

    def set_commentable
      @commentable = Book.find(params[:book_id])
    end
  end
end
