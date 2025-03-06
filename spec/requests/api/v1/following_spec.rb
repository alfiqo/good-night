require 'swagger_helper'

RSpec.describe 'api/v1/followings', type: :request do
    let(:id) { User.create!(name: 'Test User').id }
    let(:followed_id) { User.create!(name: 'Test User Followed').id }
    let(:followings) { { followed_id: followed_id } }

    path '/api/v1/users/{id}/followings' do
        post 'Follow a user' do
            tags 'Followings'
            consumes 'application/json'
            produces 'application/json'

            parameter name: :id, in: :path, type: :integer, description: 'User ID'
            parameter name: :followings, in: :body, schema: {
                type: :object,
                properties: {
                    followed_id: { type: :integer }
                },
                required: [ 'followed_id' ]
            }

            response '201', 'following created' do
                schema type: :object,
                        properties: {
                            id: { type: :integer, example: 11111 },
                            follower_id: { type: :integer, example: 22222 },
                            followed_id: { type: :integer, example: 33333 },
                            created_at: { type: :string, format: 'date-time' },
                            updated_at: { type: :string, format: 'date-time' }
                        },
                        required: [ 'id', 'follower_id', 'followed_id' ]

                run_test!
            end

            response '404', 'user not found' do
                let(:id) { 'invalid' }
                run_test!
            end
        end
    end
end
