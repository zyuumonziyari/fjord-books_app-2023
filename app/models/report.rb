# frozen_string_literal: true

class Report < ApplicationRecord
  after_save :save_mentions

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioned_relationships, class_name: 'MentionReport', foreign_key: 'mentioned_reports_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :mentioned_relationships, source: :mentioning_report

  has_many :mentioning_relationships, class_name: 'MentionReport', foreign_key: 'mentioning_reports_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :mentioning_relationships, source: :mentioned_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  MENTION_REGEXP = %r{http://\[::1\]:3000/reports/(\d+)}

  def save_mentions
    mentioning_relationships.destroy_all
    ids = content.to_s.scan(MENTION_REGEXP).flatten.uniq
    reports = Report.where(id: ids)
    self.mentioning_reports += reports
  end
end
