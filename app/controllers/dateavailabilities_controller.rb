class DateavailabilitiesController < ApplicationController
  def index
    start_date = Date.today
    end_date = start_date + 60.days

    date_availabilities = Dateavailability.where(service_date: start_date..end_date)
                                          .where("vehicle_count < ?", 50)

    render json: date_availabilities, status: :ok
  end
end
