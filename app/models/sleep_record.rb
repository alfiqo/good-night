class SleepRecord < ApplicationRecord
  belongs_to :user

  before_update :calculate_duration
  validate :woke_at_not_changed, on: :update
  validate :one_slept_at_per_day, on: :create

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

  def one_slept_at_per_day
    if user.sleep_records.where("DATE(slept_at) = ?", slept_at.to_date).exists?
      errors.add(:slept_at, "can only have one record per day")
    end
  end

  scope :last_7_days, -> {
    where(slept_at: 7.days.ago.beginning_of_day..Time.current.end_of_day)
  }
  scope :order_by_duration, -> { order(duration_minutes: :desc) }
end
