class Passenger < ApplicationRecord
  validates_prsenence_of :name
  validates_prsenence_of :age

  has_many :passenger_flights
  has_many :flights, through: :passenger_flights
end
