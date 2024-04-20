class Message < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end
