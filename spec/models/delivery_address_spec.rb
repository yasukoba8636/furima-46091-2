require 'rails_helper'

RSpec.describe DeliveryAddress, type: :model do
  subject { build(:delivery_address) }

  it { is_expected.to validate_presence_of(:postal_code) }
  it { is_expected.to allow_value('123-4567').for(:postal_code) }
  it { is_expected.not_to allow_value('1234567').for(:postal_code) }

  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to allow_value('09012345678').for(:phone) }
  it { is_expected.not_to allow_value('090-1234-5678').for(:phone) }
end
