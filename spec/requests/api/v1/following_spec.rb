require 'swagger_helper'

RSpec.describe 'api/v1/followings', type: :request do
    let(:user) { User.create!(name: 'Test User') }
    let(:id) { user.id }
    let(:followed) { User.create!(name: 'Test User Followed') }
    let(:followings) { { followed_id: followed.id } }

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

    path '/api/v1/users/{id}/followings/{following_id}' do
        delete 'Unfollow a user' do
            tags 'Followings'
            produces 'application/json'
            parameter name: :id, in: :path, type: :integer, description: 'User ID'
            parameter name: :following_id, in: :path, type: :integer, description: 'Following ID'

            response '204', 'following deleted' do
                let(:following_id) { followed.id }

                before do
                    user.followings.create!(followed_id: followed.id)
                end
                run_test!
            end

            response '404', 'user or following not found' do
                let(:id) { 'invalid' }
                let(:following_id) { 'invalid' }
                run_test!
            end
        end
    end
end
