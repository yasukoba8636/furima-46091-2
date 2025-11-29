require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid with valid attributes" do
    order = build(:order)
    order.build_delivery_address(attributes_for(:delivery_address))
    expect(order).to be_valid
  end

  it "is invalid without delivery address postal_code" do
    order = build(:order)
    order.build_delivery_address(attributes_for(:delivery_address, postal_code: nil))
    expect(order).not_to be_valid
  end
end
