# require 'swagger_helper'

RSpec.describe 'Schedule API', type: :request do
  describe 'POST /schedules' do
    let(:valid_schedule_params) do
      {
        client_firstname: 'John',
        client_lastname: 'Doe',
        client_phone: '1234567890',
        client_email: 'john@example.com',
        contact_concent: true,
        vin: 'ABC123XYZ45678965',
        vehicle_brand: 'Toyota',
        vehicle_name: 'Camry',
        licence_number: 'ABC123',
        make_year: '2022',
        purchased_date: '2022-01-01',
        warrenty_date: '2025-01-01',
        insurance_details: 'Some insurance details',
        service_date: '2024-03-11',
        timeslot_id: '1',
        purpose: 'Regular maintenance'
      }
    end

    before do
      # Create a new entry in the timeslots table
      Timeslot.create!(id: 1, starttime: "9:00", endtime: "1:00")
    end

    it 'creates a new schedule with valid parameters' do
      post '/schedules', params: valid_schedule_params.to_json, headers: { 'Content-Type': 'application/json' }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('message' => 'Schedule created successfully')
      # Add more expectations as needed
    end
  end

  describe 'GET /schedules' do
    it 'returns a list of schedules' do
      # Make a request to fetch schedules
      get '/schedules'

      expect(response).to have_http_status(:success)
      # Add expectations for the response body, if needed
    end
  end

  describe 'PATCH /schedules/:id' do

    before do
      # Create a new entry in the timeslots table
      Timeslot.create!(id: 1, starttime: "9:00", endtime: "1:00")
    end

    it 'updates an existing schedule' do


      # Make a request to update a schedule
      put "/schedules/1", params: {
        service_date: '2024-03-12',
        timeslot_id: '1',
        purpose: 'Regular maintenance'
      }.to_json, headers: { 'Content-Type': 'application/json' }

      expect(response).to_not have_http_status(:success) # 1 is a random number and will not be present for update.
      # Add expectations for the response body, if needed
    end
  end
end

# require 'swagger_helper'

# RSpec.describe 'Schedule API', type: :request do

#   let(:valid_schedule_params) do
#     {
#       client_firstname: 'John',
#       client_lastname: 'Doe',
#       client_phone: '1234567890',
#       client_email: 'john@example.com',
#       contact_concent: true,
#       vin: 'ABC123XYZ45678965',
#       vehicle_brand: 'Toyota',
#       vehicle_name: 'Camry',
#       licence_number: 'ABC123',
#       make_year: '2022',
#       purchased_date: '2022-01-01',
#       warrenty_date: '2025-01-01',
#       insurance_details: 'Some insurance details',
#       service_date: '2024-03-11',
#       timeslot_id: '1',
#       purpose: 'Regular maintenance'
#     }
#   end

#   path '/schedules' do

#     post('create schedule') do
#       description 'Create schedules'
#       tags 'Schedules'
#       consumes 'application/json'
#       parameter name: :schedule, in: :body, schema: {
#         type: :object,
#         properties: {
#           client_firstname: { type: :string },
#           client_lastname: { type: :string },
#           client_phone: { type: :string },
#           client_email: { type: :string },
#           contact_concent: { type: :boolean },
#           vin: { type: :string },
#           vehicle_brand: { type: :string },
#           vehicle_name: { type: :string },
#           licence_number: { type: :string },
#           make_year: { type: :string },
#           purchased_date: { type: :string },
#           warrenty_date: { type: :string },
#           insurance_details: { type: :string },
#           service_date: { type: :string },
#           timeslot_id: { type: :string },
#           purpose: { type: :string }
#         }
#       }

#       response '200', 'successful' do
#         schema type: :object,
#           properties: {
#             message: 'Schedule created successfully',
#             # Add other properties here as needed
#           },
#           required: %w[id]

#         run_test!
#       end
#     end
#   describe 'POST /schedules' do
#     it 'creates a new schedule with valid parameters' do
#       post '/schedules', params: { schedule: valid_schedule_params }

#       expect(response).to have_http_status(:success)
#       expect(JSON.parse(response.body)).to include('example')
#       # Add more expectations as needed
#     end
#   end

#     get('list schedules') do
#       description 'Get a list of schedules'
#       tags 'Schedules'

#       response(200, 'successful') do

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end

#     path '/schedules/{id}' do
#       # You'll want to customize the parameter types...
#       parameter name: 'id', in: :path, type: :string, description: 'id'

#       put('update schedule') do
#         description 'Update schedules'
#         tags 'Schedules'
#         response(200, 'successful') do
#           let(:id) { '1' }

#           after do |example|
#             example.metadata[:response][:content] = {
#               'application/json' => {
#                 example: JSON.parse(response.body, symbolize_names: true)
#               }
#             }
#           end
#           run_test!
#         end
#       end
#     end
#   end
# end
