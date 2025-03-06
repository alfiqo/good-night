class AddDurationToSleepRecord < ActiveRecord::Migration[8.0]
  def change
    add_column :sleep_records, :duration_minutes, :integer
    add_index :sleep_records, :duration_minutes
  end
end
