require 'swagger_helper'

RSpec.describe 'Date Availability API', type: :request do

  path '/dateavailabilities' do

    get('list dateavailabilities') do
      description 'Get all available dates to schedule'
      tags 'Date Availability'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
