
module Api::V1
    class FollowingsController < ApplicationController
        before_action :is_user_exist?, only: [ :create, :destroy ]

        def create
            user = @user
            following = user.followings.create!(followed_id: params[:followed_id])
            render json: following, status: :created
        end

        def destroy
            user = @user
            following = Following.find_by(follower_id: user.id, followed_id: params[:following_id])
            if following.present?
                following.destroy
                head :no_content
            else
                render json: { error: 'Following record not found' }, status: :not_found
            end
        end

        private

        def is_user_exist?
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "User not found" }, status: :not_found
        end
    end
end
