class SleepRecord < ApplicationRecord
  belongs_to :user

  before_update :calculate_duration
  validate :woke_at_not_changed, on: :update

  private

  def calculate_duration
    return if slept_at.blank? || woke_at.blank?

    self.duration_minutes = ((woke_at - slept_at) / 60).to_i
  end

  def woke_at_not_changed
    if woke_at_changed? && woke_at_was.present?
      errors.add(:woke_at, "can only be set once")
    end
  end
end
