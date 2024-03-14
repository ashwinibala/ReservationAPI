class SchedulesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_schedule, only: [:update]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from StandardError, with: :handle_error

  def index
    @schedules = Schedule.all
    render json: @schedules.as_json
  end
  def create
    # Parse incoming parameters
    parsed_params = parse_schedule_params(params)

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
      vehicle = Vehicle.create(parsed_params[:vehicle_params].merge(client_id: client.id))
    end

    # Create schedule
    existing_schedule = Schedule.where("vehicle_id = ? AND completed_date IS NULL AND service_date > ?", vehicle.id, Date.today).first

    p existing_schedule

    if existing_schedule
      # Schedule already exists
      render json: { message: "Upcoming Schedule is already available for the vehicle." }, status: :unprocessable_entity
    else
      dateavailability = Dateavailability.find_by(service_date: parsed_params[:schedule_params][:service_date])
      p dateavailability
      if !dateavailability
        Dateavailability.find_or_create_by(service_date: parsed_params[:schedule_params][:service_date], vehicle_count: 1, timeslot_id: parsed_params[:schedule_params][:timeslot_id])
        schedule = Schedule.create(parsed_params[:schedule_params].merge(vehicle_id: vehicle.id))
      elsif dateavailability.vehicle_count < 50
        schedule = Schedule.create(parsed_params[:schedule_params].merge(vehicle_id: vehicle.id))
        dateavailability.vehicle_count += 1
        dateavailability.save!
      else
        render json: { message: "Schedule not created due to unavailable date and slot" }, status: :unprocessable_entity
      end

      if schedule.persisted?
        render json: { message: "Schedule created successfully" }, status: :created
      else
        render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    existing_schedule = Schedule.where("vehicle_id = ? AND completed_date IS NULL AND service_date > ?", @schedule.vehicle_id, Date.today).first
    if existing_schedule.service_date.strftime("%Y-%m-%d") == params[:service_date]
      render json: { message: "Schedule exists for the same date" }, status: :unprocessable_entity
      return
    end
    existing_date_availability = Dateavailability.find_by(service_date: existing_schedule.service_date)
    new_date_availability = Dateavailability.find_by(service_date: params[:service_date], timeslot_id: params[:timeslot_id])

    if existing_schedule
      if !new_date_availability
        if @schedule.update(schedule_update_params)
          date_availability_params = params.permit(:service_date, :timeslot_id)
          date_availability = Dateavailability.find_or_create_by(date_availability_params.merge(vehicle_count: 1))
          render json: @schedule, status: :ok
        end
      elsif new_date_availability.vehicle_count < 50
        if @schedule.update(schedule_update_params)
          existing_date_availability.vehicle_count -= 1
          existing_date_availability.save!
          new_date_availability.vehicle_count += 1
          new_date_availability.save!
          render json: @schedule, status: :ok
        else
          render json: @schedule.errors, status: :unprocessable_entity
        end
      else
        render json: { message: "New service date is not available or vehicle count exceeds limit" }, status: :unprocessable_entity
      end
    else
      render json: { message: "No existing schedule found to update" }, status: :unprocessable_entity
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
    schedule_params = params.require(:schedule).permit(:service_date, :timeslot_id, :purpose)

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

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_update_params
    params.require(:schedule).permit(:vehicle_id, :service_date, :time_slot_id, :purpose)
  end
  def date_availabilities_update_params
    dateavailability_params = params.require(:dateavailability).permit(:service_date, :timeslot_id, :vehicle_count)
  end
  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def handle_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end
end
