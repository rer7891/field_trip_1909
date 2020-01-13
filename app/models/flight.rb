class Flight <ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  belongs_to :airline
  have_many :passenger_flights
  have_many :passengers, through: :flights
end
