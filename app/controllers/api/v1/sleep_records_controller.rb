module Api::V1
    class SleepRecordsController < ApplicationController
        def create
            user = User.find(params[:id])
            sleep_record = user.sleep_records.create!(sleep_record_params)
            render json: sleep_record, status: :created
        end

        private

        def sleep_record_params
            {
                slept_at: Time.now,
                woke_at: nil
            }
        end
    end
end
