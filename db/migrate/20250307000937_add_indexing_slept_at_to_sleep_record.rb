class AddIndexingSleptAtToSleepRecord < ActiveRecord::Migration[8.0]
  def change
    add_index :sleep_records, :slept_at
  end
end
