class Order < ApplicationRecord
  belongs_to :item
  belongs_to :buyer, class_name: "User"

  has_one :delivery_address, dependent: :destroy
  accepts_nested_attributes_for :delivery_address
end

