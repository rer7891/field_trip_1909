class PassengersController < ApplicationController

  def show
    @passenger = Passenger.find(params[:id])
  end
end
