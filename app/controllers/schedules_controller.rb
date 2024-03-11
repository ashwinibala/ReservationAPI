class SchedulesController < ApplicationController
  def create
    # Parse incoming parameters
    schedule_params = parse_schedule_params(params[:schedule])

    # Create client
    # Check if client with the same phone number or email already exists
    existing_client = Client.find_by(phone: parsed_params[:client][:phone]) || Client.find_by(email: parsed_params[:client][:email])

    if existing_client
      # Client already exists, use existing client
      client = existing_client
    else
      # Client does not exist, create new client
      client = Client.create(client_params(schedule_params))
    end

    # Create Vehicle
    # Check if vehicle with the same VIN already exists
    existing_vehicle = Vehicle.find_by(vin: parsed_params[:vehicle][:vin])

    if existing_vehicle
      # Vehicle already exists, use existing vehicle
      vehicle = existing_vehicle
    else
      # Vehicle does not exist, create new vehicle
      vehicle = Vehicle.create(vehicle_params(schedule_params.merge(client_id: client.id)))
    end

    # Create schedule
    schedule = Schedule.create(schedule_params.merge(client_id: client.id, vehicle_id: vehicle.id))

    if schedule.persisted?
      render json: { message: "Schedule created successfully" }, status: :created
    else
      render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private


  def parse_schedule_params(params)
    # Split params into client_params and schedule_params
    client_params = params.slice!(:client_firstname, :client_lastname, :client_phone, :client_email, :contact_concent)
    client_params[:firstname] = params.delete(:client_firstname)
    client_params[:lastname] = params.delete(:client_lastname)
    client_params[:phone] = params.delete(:client_phone)
    client_params[:email] = params.delete(:client_email)
    vehicle_params = params.slice!(:vin, :vehicle_brand, :vehicle_name, :licence_number, :make_year, :purchased_date, :warrenty_date, :insurance_details)
    vehicle_params[:name] = params.delete(:vehicle_brand)
    vehicle_params[:brand] = params.delete(:client_lastname)
    schedule_params = params

    # Convert date and time strings to appropriate data types
    schedule_params[:date] = Date.parse(schedule_params[:date])
    schedule_params[:start_time] = Time.parse(schedule_params[:start_time])
    schedule_params[:end_time] = Time.parse(schedule_params[:end_time])

    { client_params: client_params, schedule_params: schedule_params }
  end

  def client_params(params)
    # Permit and return client parameters
    params.require(:client).permit(:name, :phone, :email)
  end
end


# RequestBody

# {
#   client_firstname:
#   client_lastname:
#   client_phone:
#   client_email:
#   contact_concent:
#   vin:
#   vehicle_brand:
#   vehicle_name:
#   licence_number:
#   make_year:
#   purchased_date:
#   warrenty_date:
#   insurance_details:
#   service_date:
#   time_slot_id:
#   purpose_id:
# }
