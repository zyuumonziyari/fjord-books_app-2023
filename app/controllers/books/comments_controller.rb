# frozen_string_literal: true

module Books
  class CommentsController < Comments::BaseController
    def render_commentable(comment)
      render 'books/show', locals: { book: @commentable, comment: comment }, status: :unprocessable_entity  
    end

    private

    def set_commentable
      @commentable = Book.find(params[:book_id])
    end
  end
end
