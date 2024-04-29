# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
