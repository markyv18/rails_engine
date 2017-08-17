require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "instance methods" do
    describe "#name" do
      it "should return the Full name of the customer" do
        customer = Customer.new(first_name: "Harry", last_name: "Boots")

        expected = "Harry Boots"

        expect(customer.name).to eq expected
      end
    end
  end
end
