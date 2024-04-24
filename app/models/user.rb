# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :avatar_content_type

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end

  def avatar_content_type
    if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:avatar, :avatar_content_type)
    end
  end
end
