
module Api::V1
    class FollowingsController < ApplicationController
        before_action :is_user_exist?, only: [:create]

        def create
            user = @user
            following = user.followings.create!(followed_id: params[:followed_id])
            render json: following, status: :created
        end

        private

        def is_user_exist?
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "User not found" }, status: :not_found
        end
    end
end
