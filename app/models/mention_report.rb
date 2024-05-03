class MentionReport < ApplicationRecord
  belongs_to :mentioned_report, class_name: "Report", foreign_key: "mentioned_reports_id"
  belongs_to :mentioning_report, class_name: "Report", foreign_key: "mentioning_reports_id"
end
