# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :content, presence: true

  def display_user_name
    user.name? ? user.name : user.email
  end
end
