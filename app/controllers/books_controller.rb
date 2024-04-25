# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.order(updated_at: :desc, id: :desc).page(params[:page])
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: t('controllers.common.notice_create', title: @book.title)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('controllers.common.notice_update', title: @book.title)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: t('controllers.common.notice_destroy', title: @book.title)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end
