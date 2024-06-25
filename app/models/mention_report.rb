# frozen_string_literal: true

class MentionReport < ApplicationRecord
  belongs_to :mentioned_report, class_name: 'Report', foreign_key: 'mentioned_reports_id', inverse_of: :mentioned_relationships
  belongs_to :mentioning_report, class_name: 'Report', foreign_key: 'mentioning_reports_id', inverse_of: :mentioning_relationships
end
