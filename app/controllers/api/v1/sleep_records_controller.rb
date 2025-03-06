module Api::V1
    class SleepRecordsController < ApplicationController
        before_action :sleep_at_params, only: :create
        before_action :wake_at_params, only: :update

        def create
            user = User.find(params[:id])
            sleep_record = user.sleep_records.create!(sleep_at_params)
            render json: sleep_record, status: :created
        end

        def update
            # byebug
            sleep_record = SleepRecord.find(params[:sleep_record_id])
            sleep_record.update!(wake_at_params)
            render json: sleep_record, status: :ok
        end

        private

        def sleep_at_params
            {
                slept_at: Time.now,
                woke_at: nil
            }
        end

        def wake_at_params
            {
                woke_at: Time.now
            }
        end
    end
end
