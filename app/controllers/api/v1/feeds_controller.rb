module Api::V1
    class FeedsController < ApplicationController
        before_action :is_user_exist?

        def index
            feeds = @user.sleep_records_from_followed_users
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
