class VehiclesController < ApplicationController
  def index
    if params[:vin]
      @vehicles = Vehicle.includes(:schedules).where(vin: params[:vin])
    elsif params[:licence_number]
      @vehicles = Vehicle.includes(:schedules).where(licence_number: params[:licence_number])
    else
      @vehicles = Vehicle.includes(:schedules).all
    end

    render json: @vehicles.as_json({ include: :schedules })

  end
end
