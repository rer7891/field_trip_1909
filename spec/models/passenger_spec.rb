require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
  end

  describe "relationships" do
    it {should have_many :passenger_flights}
    it {should have_many(:flights).through(:passenger_flights)}
  end
end
