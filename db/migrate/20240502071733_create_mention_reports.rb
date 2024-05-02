class CreateMentionReports < ActiveRecord::Migration[7.0]
  def change
    create_table :mention_reports do |t|
      t.integer :mentioning_reports_id
      t.integer :mentioned_reports_id

      t.timestamps
    end
    add_index :mention_reports, :mentioned_reports_id
    add_index :mention_reports, :mentioning_reports_id
    add_index :mention_reports, [:mentioned_reports_id, :mentioning_reports_id], unique: true, name: 'index_mention_reports_on_ids'
  end
end
