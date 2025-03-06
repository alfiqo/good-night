require 'swagger_helper'

RSpec.describe 'api/v1/sleep_records', type: :request do
    path '/api/v1/users/{id}/sleep_records' do
    post 'Clock in a sleep record' do
      tags 'Sleep Records'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'User ID'

      response '201', 'sleep record created' do
        schema type: :object,
                 properties: {
                   id: { type: :integer, example: 11111 },
                   user_id: { type: :integer, example: 22222 },
                   slept_at: { type: :string, format: 'date-time' },
                   woke_at: { type: :string, format: 'date-time', nullable: true, example: nil },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: [ 'id', 'user_id', 'slept_at' ]

        let(:id) { 11111 }
        let(:user_id) { id }
        let(:slept_at) { Time.now }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
