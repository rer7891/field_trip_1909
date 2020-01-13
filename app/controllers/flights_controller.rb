class FlightsController < ApplicationController

  def show
    @flight = Flight.find(params[:id])
  end

  def new
    passenger = Passenger.find(params[:id])
    flight = Flight.where(number: params[:flight][:number])
    passenger.flights << flight
    redirect_to "/passengers/#{passenger.id}"
    end
  end
