require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through(:passenger_flights)}
  end

  describe 'methods' do
    it "can count adults and minors on a flight" do
      southwest = Airline.create(name: "Southwest")

      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      passenger_1 = Passenger.create(name: "Susie", age: 37)
      passenger_2 = Passenger.create(name: "Bill", age: 7)
      passenger_3 = Passenger.create(name: "Tom", age: 23)
      passenger_4 = Passenger.create(name: "Phil", age: 53)
      passenger_5 = Passenger.create(name: "Becky", age: 10)

      southwest_1.passengers << [passenger_1, passenger_2, passenger_3, passenger_4, passenger_5]

      expect(southwest_1.adult_count).to eq(3)
      expect(southwest_1.minor_count).to eq(2)
    end
  end
end
