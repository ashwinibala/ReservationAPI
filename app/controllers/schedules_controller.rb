class SchedulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Parse incoming parameters
    parsed_params = parse_schedule_params(params)

    p parsed_params
    p parsed_params[:client_params][:phone]

    # Create client
    # Check if client with the same phone number or email already exists
    existing_client = Client.find_by(phone: parsed_params[:client_params][:phone]) || Client.find_by(email: parsed_params[:client_params][:email])

    if existing_client
      # Client already exists, use existing client
      client = existing_client
    else
      # Client does not exist, create new client
      client = Client.create(parsed_params[:client_params])
    end

    # Create Vehicle
    # Check if vehicle with the same VIN already exists
    existing_vehicle = Vehicle.find_by(vin: parsed_params[:vehicle_params][:vin])

    if existing_vehicle
      # Vehicle already exists, use existing vehicle
      vehicle = existing_vehicle
    else
      # Vehicle does not exist, create new vehicle
      vehicle = Vehicle.create(parsed_params[:vehicle_params].merge(clients_id: client.id))
    end

    # Create schedule
    existing_schedule = Schedule.where("vehicles_id = ? AND completed_date IS NULL AND service_date > ?", vehicle.id, Date.today).first
    if existing_schedule
      # Schedule already exists
      render json: { message: "Schedule is already available for the vehicle" }, status: :unprocessable_entity
    else
      schedule = Schedule.create(parsed_params[:schedule_params].merge(vehicles_id: vehicle.id))

      if schedule.persisted?
        render json: { message: "Schedule created successfully" }, status: :created
      else
        render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def parse_schedule_params(params)
    # Split params into client_params and schedule_params

    # Permit and extract the required parameters for creating a client
    client_params = params.permit(:client_firstname, :client_lastname, :client_phone, :client_email, :contact_concent)

    # Permit and extract the required parameters for creating a vehicle
    vehicle_params = params.permit(:vin, :vehicle_brand, :vehicle_name, :licence_number, :make_year, :purchased_date, :warrenty_date, :insurance_details)

    # Permit and extract the required parameters for creating a schedule
    schedule_params = params.require(:schedule).permit(:service_date, :timeslots_id, :purposes_id)

    client_params[:firstname] = client_params.delete(:client_firstname)
    client_params[:lastname] = client_params.delete(:client_lastname)
    client_params[:phone] = client_params.delete(:client_phone)
    client_params[:email] = client_params.delete(:client_email)

    vehicle_params[:name] = vehicle_params.delete(:vehicle_name)
    vehicle_params[:brand] = vehicle_params.delete(:vehicle_brand)

    # Convert date and time strings to appropriate data types
    vehicle_params[:purchased_date] = Date.parse(vehicle_params[:purchased_date]) rescue nil
    vehicle_params[:warrenty_date] = Date.parse(vehicle_params[:warrenty_date]) rescue nil
    schedule_params[:service_date] = Date.parse(schedule_params[:service_date]) rescue nil

    p client_params
    p vehicle_params
    p schedule_params

    { client_params: client_params, vehicle_params: vehicle_params, schedule_params: schedule_params }
  end
end
