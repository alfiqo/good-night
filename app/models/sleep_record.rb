class SleepRecord < ApplicationRecord
  belongs_to :user

  before_update :calculate_duration
  
  private

  def calculate_duration
    return if slept_at.blank? || woke_at.blank? # Ensure both timestamps are present

    self.duration_minutes = ((woke_at - slept_at) / 60).to_i # Convert seconds to minutes
  end
end
