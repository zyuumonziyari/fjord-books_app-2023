# frozen_string_literal: true

require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @book_one = books(:one)
    @book_two = books(:two)
    @user = users(:one)

    sign_in @user
  end

  test 'should get index' do
    get books_url
    assert_response :success
    assert_select 'nav.pagination'
  end

  test 'should get new' do
    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post books_url, params: { 
        book: {
          memo: @book_one.memo,
          title: @book_one.title,
          author: @book_one.author,
          picture: fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'pikachuu.jpg'))
        }
      }
    end

    assert_redirected_to book_url(Book.last)
    assert_equal "本が作成されました。", flash[:notice]
  end

  test 'should show book' do
    get book_url(@book_one)
    assert_response :success
  end

  test 'should get edit' do
    get edit_book_url(@book_one)
    assert_response :success
  end

  test 'should update book' do
    patch book_url(@book_one), params: {
      book: {
        memo: @book_two.memo,
        title: @book_two.title,
        author: @book_two.author,
        picture: fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'kabigon.jpg'))
      }
    }
    assert_redirected_to book_url(@book_one)
    assert_equal "本が更新されました。", flash[:notice]

    @book_one.reload
    assert_equal 'MyString2', @book_one.title
    assert_equal 'MyText2', @book_one.memo
    assert_equal 'MyAuthor2', @book_one.author
    assert @book_one.picture.file
    assert_match /kabigon\.jpg$/, @book_one.picture.url
  end

  test 'should destroy book' do
    assert_difference('Book.count', -1) do
      delete book_url(@book_one)
    end

    assert_redirected_to books_url
    assert_equal "本が削除されました。", flash[:notice]
  end
end
