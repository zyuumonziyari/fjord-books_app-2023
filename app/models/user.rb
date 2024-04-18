# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
  end
  validate :avatar_content_type

  def avatar_content_type
    errors.add(:avatar, :avatar_content_type) if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])
  end
end
