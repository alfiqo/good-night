module Api::V1
    class FeedsController < ApplicationController
        before_action :is_user_exist?

        def index
            cache_key = "user_#{@user.id}_feeds"
            feeds = Rails.cache.fetch(cache_key, expires_in: 60.seconds) do
                @user.sleep_records_from_followed_users.to_a
            end
            render json: feeds
        end

        private

        def is_user_exist?
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "User not found" }, status: :not_found
        end
    end
end
