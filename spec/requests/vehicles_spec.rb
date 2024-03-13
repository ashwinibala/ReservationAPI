require 'swagger_helper'

RSpec.describe 'Vehicles API', type: :request do
  path '/vehicles' do

    get('list vehicles by VIN') do
      description 'Get a list of vehicles by VIN'
      tags 'Vehicles'

      parameter name: :vin, in: :query, type: :string, required: true

      response '200', 'successful' do
        run_test!
      end
    end

    get('list vehicles by license number') do
      description 'Get a list of vehicles by license number'
      tags 'Vehicles'

      parameter name: :licence_number, in: :query, type: :string, required: true

      response '200', 'successful' do
        run_test!
      end
    end

    get('list all vehicles') do
      description 'Get a list of all vehicles'
      tags 'Vehicles'

      response '200', 'successful' do
        run_test!
      end
    end
  end
end
