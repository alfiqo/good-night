class User < ApplicationRecord
    has_many :sleep_records

    has_many :followings, foreign_key: :follower_id, dependent: :destroy
    has_many :followed_users, through: :followings, source: :followed
end
