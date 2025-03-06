class CreateSleepRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_records do |t|
      t.timestamp :slept_at
      t.timestamp :woke_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
