require 'swagger_helper'

RSpec.describe 'Schedules API', type: :request do
  path '/schedules' do
    get('list schedules') do
      description 'Get a list of schedules'
      tags 'Schedules'

      response '200', 'successful' do
        run_test!
      end
    end

    post('create schedule') do
      description 'Create a new schedule'
      tags 'Schedules'

      consumes 'application/json'
      parameter name: :schedule, in: :body, schema: {
        type: :object,
        properties: {
          client_firstname: { type: :string },
          client_lastname: { type: :string },
          client_phone: { type: :string },
          client_email: { type: :string },
          contact_concent: { type: :boolean },
          vin: { type: :string },
          vehicle_brand: { type: :string },
          vehicle_name: { type: :string },
          licence_number: { type: :string },
          make_year: { type: :string },
          purchased_date: { type: :string },
          warrenty_date: { type: :string },
          insurance_details: { type: :string },
          service_date: { type: :string },
          timeslot_id: { type: :string },
          purpose_id: { type: :string }
        },
        required: %w[client_firstname client_lastname client_phone client_email vin service_date timeslot_id purpose_id]
      }

      response '201', 'successful' do
        run_test!
      end

      response '422', 'unprocessable entity' do
        run_test!
      end
    end
  end
end
