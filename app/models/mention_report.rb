class MentionReport < ApplicationRecord
  belongs_to :mentioned_reports_id, class_name: ”Report”
  belongs_to :mentioning_reports_id, class_name: ”Report”
end
