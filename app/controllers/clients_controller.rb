class ClientsController < ApplicationController
  # GET /clients
  def index
    if params[:phone]
      @clients = Client.includes(vehicles: :schedules).where(phone: params[:phone])
    elsif params[:email]
      @clients = Client.includes(vehicles: :schedules).where(email: params[:email])
    else
      @clients = Client.includes(vehicles: :schedules).all
    end

    render json: @clients.as_json(include: { vehicles: { include: :schedules } })

  end
end
