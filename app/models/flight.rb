class Flight <ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights
end
