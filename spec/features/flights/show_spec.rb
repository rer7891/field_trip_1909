require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before :each do
    @southwest = Airline.create(name: "Southwest")
    @american = Airline.create(name: "American")

    @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    @passenger_1 = Passenger.create(name: "Susie", age: 37)
    @passenger_2 = Passenger.create(name: "Bill", age: 7)
    @passenger_3 = Passenger.create(name: "Tom", age: 18)
    @passenger_4 = Passenger.create(name: "Phil", age: 53)
    @passenger_5 = Passenger.create(name: "Becky", age: 10)

    @southwest_1.passengers << [@passenger_1, @passenger_2, @passenger_3]

    visit "/flights/#{@southwest_1.id}"
  end
  it "should see all flight details"  do
    expect(page).to have_content(@southwest_1.number)
    expect(page).to have_content(@southwest_1.date)
    expect(page).to have_content(@southwest_1.time)
    expect(page).to have_content(@southwest_1.departure_city)
    expect(page).to have_content(@southwest_1.arrival_city)
  end
  it "should see airline and all passengers" do
    expect(page).to have_content(@southwest.name)

    within "#passengers-#{@passenger_2.id}" do
      expect(page).to have_content(@passenger_2.name)
    end
    within "#passengers-#{@passenger_2.id}" do
      expect(page).to have_content(@passenger_2.name)
    end
    within "#passengers-#{@passenger_3.id}" do
      expect(page).to have_content(@passenger_3.name)
    end
    expect(page).not_to have_content(@american.name)
    expect(page).not_to have_content(@passenger_4.name)
  end
  it "can see a list counting minors and adults on the flight" do
    @southwest_1.passengers << [@passenger_4, @passenger_5]
    visit "/flights/#{@southwest_1.id}"

    expect(page).to have_content("There are 3 adults on this flight")
    expect(page).to have_content("There are 2 minors on this flight")
  end
end
