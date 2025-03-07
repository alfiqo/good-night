require 'swagger_helper'

RSpec.describe 'api/v1/feeds', type: :request do
    let(:user) { User.create!(name: 'Test User') }
    let(:id) { user.id }
    let(:page) { 1 }
    let(:per_page) { 10 }

    path '/api/v1/users/{id}/feeds' do
        get 'Get all feeds' do
            tags 'Feeds'
            produces 'application/json'

            parameter name: :id, in: :path, type: :integer, description: 'User ID'
            parameter name: :page, in: :query, type: :integer, description: 'Page number'
            parameter name: :per_page, in: :query, type: :integer, description: 'Number of feeds per page'

            response '200', 'returns all feeds' do
                run_test!
            end

            response '404', 'user not found' do
                let(:id) { 'invalid' }

                run_test!
            end
        end
    end
end
