require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
  end

  context '購入できるとき' do
    it 'すべての情報が正しく入力されていれば購入できる' do
      expect(@order_shipping).to be_valid
    end

    it 'buildingが空でも購入できる' do
      @order_shipping.building = ''
      expect(@order_shipping).to be_valid
    end
  end

  context '購入できないとき' do
    it 'postal_codeが空では購入できない' do
      @order_shipping.postal_code = ''
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeが正しい形式でないと購入できない' do
      @order_shipping.postal_code = '1234567'
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Postal code is invalid")
    end

    it 'prefecture_idが1では購入できない' do
      @order_shipping.prefecture_id = 1
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Prefecture must be other than 1")
    end

    it 'phone_numberがハイフン入りだと購入できない' do
      @order_shipping.phone_number = '090-1234-5678'
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
    end
  end
end
