module Api::V1
    class FeedsController < ApplicationController
        before_action :is_user_exist?

        def index
            page = params[:page] || 1
            per_page = params[:per_page] || 10
            cache_key = "user_#{@user.id}_feeds_page_#{page}_per_#{per_page}"

            feeds = Rails.cache.fetch(cache_key, expires_in: 60.seconds) do
              @user.sleep_records_from_followed_users.page(page).per(per_page).to_a
            end

            render json: {
              feeds: feeds,
              meta: {
                current_page: page.to_i,
                per_page: per_page.to_i,
                total_pages: @user.sleep_records_from_followed_users.page(page).per(per_page).total_pages,
                total_count: @user.sleep_records_from_followed_users.count
              }
            }
        end

        private

        def is_user_exist?
            @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: { error: "User not found" }, status: :not_found
        end
    end
end
