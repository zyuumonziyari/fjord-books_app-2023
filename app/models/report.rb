class Report < ApplicationRecord
    belongs_to :user
    has_many :messages, as: :commentable
end
