require 'swagger_helper'

RSpec.describe 'api/v1/feeds', type: :request do
    let(:user) { User.create!(name: 'Test User') }
    let(:id) { user.id }

    path '/api/v1/users/{id}/feeds' do
        get 'Get all feeds' do
            tags 'Feeds'
            produces 'application/json'

            parameter name: :id, in: :path, type: :integer, description: 'User ID'

            response '200', 'returns all feeds' do
                let(:id) { user.id }

                run_test!
            end

            response '404', 'user not found' do
                let(:id) { 'invalid' }

                run_test!
            end
        end
    end
end
