require 'swagger_helper'

RSpec.describe 'Clients API', type: :request do
  path '/clients' do
    # List clients by phone
    get('list clients by phone') do
      description 'Get a list of clients by phone number'
      tags 'Clients'

      parameter name: :phone, in: :query, type: :string, required: true

      response '200', 'successful' do
        run_test!
      end
    end

    # List clients by email
    get('list clients by email') do
      description 'Get a list of clients by email'
      tags 'Clients'

      parameter name: :email, in: :query, type: :string, required: true

      response '200', 'successful' do
        run_test!
      end
    end

    # List all clients
    get('list all clients') do
      description 'Get a list of all clients'
      tags 'Clients'

      response '200', 'successful' do
        run_test!
      end
    end
  end
end
