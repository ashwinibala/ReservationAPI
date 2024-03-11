class SchedulesController < ApplicationController
  def create
    # Parse incoming parameters
    schedule_params = parse_schedule_params(params[:schedule])

    # Create client
    client = Client.create(client_params(schedule_params))

    # Create schedule
    schedule = Schedule.create(schedule_params.merge(client_id: client.id))

    if schedule.persisted?
      render json: { message: "Schedule created successfully" }, status: :created
    else
      render json: { errors: schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def parse_schedule_params(params)
    # Split params into client_params and schedule_params
    client_params = params.slice!(:start_time, :end_time)
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
