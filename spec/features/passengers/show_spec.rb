require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a passenger show page I see a passenger name" do
    it "also shows all flight numbers listed that link to the flight show page" do
      southwest = Airline.create(name: "Southwest")
      american = Airline.create(name: "American")

      southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      southwest_2 = southwest.flights.create(number: "SW2", date: "09/09/21", time: "100", departure_city: "Milwaukee", arrival_city: "Chattanooga")
      american_1 = american.flights.create(number: "AM1", date: "01/09/20", time: "1120", departure_city: "San Fransisco", arrival_city: "Chicago")
      american_2 = american.flights.create(number: "AM2", date: "03/15/21", time: "100", departure_city: "Cincinatti", arrival_city: "Austin")
      passenger_1 = Passenger.create(name: "Susie", age: 37)
      passenger_2 = Passenger.create(name: "Tom", age: 56)
      passenger_1.flights << [southwest_1, southwest_2, american_1]

      visit "/passengers/#{passenger_1.id}"

      expect(page).to have_content(passenger_1.name)
      expect(page).to_not have_content(passenger_2.name)

      within "#flight-#{southwest_1.id}" do
        expect(page).to have_link(southwest_1.number)
        click_link southwest_1.number
        expect(current_path).to eq("/flights/#{southwest.id}")
        visit "/passengers/#{passenger_1.id}"
      end

      within "#flight-#{southwest_1.id}" do
        expect(page).to have_link(southwest_1.number)
        click_link southwest_1.number
        expect(current_path).to eq("/flights/#{southwest.id}")
        visit "/passengers/#{passenger_1.id}"
      end

      within "#flight-#{southwest_1.id}" do
        expect(page).to have_link(southwest_1.number)
        click_link southwest_1.number
        expect(current_path).to eq("/flights/#{southwest.id}")
        visit "/passengers/#{passenger_1.id}"
      end

      expect(page).to_not have_link(american_2.number)
    end
  end
end
