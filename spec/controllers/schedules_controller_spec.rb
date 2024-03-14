require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new schedule' do
        post :create, params: {
          client_firstname: 'John',
          client_lastname: 'Doe',
          client_phone: '1234567890',
          client_email: 'john@example.com',
          contact_concent: true,
          vin: 'ABC123XYZ45678965',
          vehicle_brand: 'Toyota',
          vehicle_name: 'Camry',
          licence_number: 'ABC123',
          make_year: '2020',
          purchased_date: '2022-01-01',
          warrenty_date: '2025-01-01',
          insurance_details: 'Some insurance details',
          service_date: '2024-03-15',
          timeslot_id: 1,
          purpose: 'Some purpose'
        }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Schedule created successfully')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post :create, params: { invalid_param: 'value' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:schedule) { create(:schedule) }

    context 'with valid parameters' do
      it 'updates the schedule' do
        put :update, params: {
          id: schedule.id,
          service_date: '2024-03-16',
          timeslot_id: 1,
          purpose: 'Updated purpose'
        }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['service_date']).to eq('2024-03-16')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        put :update, params: { id: schedule.id, invalid_param: 'value' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when schedule with same service date already exists' do
      let!(:existing_schedule) { create(:schedule, service_date: '2024-03-16') }

      it 'returns unprocessable entity status' do
        put :update, params: { id: schedule.id, service_date: '2024-03-16', timeslot_id: 1, purpose: 'Updated purpose' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('Schedule exists for the same date')
      end
    end
  end
end
