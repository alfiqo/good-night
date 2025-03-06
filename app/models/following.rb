class Following < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validate :cannot_follow_self
  validates :follower_id, uniqueness: { scope: :followed_id, message: "can only follow a user once" }

  private

  def cannot_follow_self
    errors.add(:follower_id, "can't follow yourself") if follower_id == followed_id
  end
end
