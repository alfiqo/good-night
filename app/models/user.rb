class User < ApplicationRecord
    has_many :sleep_records

    has_many :followings, foreign_key: :follower_id, dependent: :destroy
    has_many :followed_users, through: :followings, source: :followed

    def sleep_records_from_followed_users
        SleepRecord.where(user_id: followed_users.pluck(:id))
        .last_7_days
        .order_by_duration
    end
end
