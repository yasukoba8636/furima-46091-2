require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品できる場合' do
    it 'すべての項目が正しく入力されていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '商品出品できない場合' do
    it 'nameが空だと出品できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it 'priceが300未満だと出品できない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
  end
end
