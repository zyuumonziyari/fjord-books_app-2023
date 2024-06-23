# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book_one = books(:one)
    @book_two = books(:two)
    @user = users(:one)

    visit root_url
    fill_in 'Eメール', with: @user.email
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'

    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit books_url
    assert_text '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: @book_one.title
    fill_in 'メモ', with: @book_one.memo
    fill_in '著者', with: @book_one.author
    attach_file '画像', Rails.root.join('test/fixtures/files/pikachuu.jpg')

    click_on '登録する'

    assert_text '本が作成されました。'
    assert_selector 'img[src*="pikachuu.jpg"]'
    click_on '本の一覧に戻る'
  end

  test 'should update book' do
    visit book_url(@book_one)
    click_on 'この本を編集'

    fill_in 'タイトル', with: @book_two.title
    fill_in 'メモ', with: @book_two.memo
    fill_in '著者', with: @book_two.author
    attach_file '画像', Rails.root.join('test/fixtures/files/kabigon.jpg')

    click_on '更新する'

    assert_text '本が更新されました。'
    assert_selector 'img[src*="kabigon.jpg"]'
    click_on '本の一覧に戻る'
  end

  test 'should destroy book' do
    visit book_url(@book_one)
    click_on 'この本を削除'

    assert_text '本が削除されました。'
  end
end
