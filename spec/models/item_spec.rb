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

    it 'descriptionが空だと出品できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'category_idが1だと出品できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it 'condition_idが1だと出品できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end

    it 'shipping_fee_idが1だと出品できない' do
      @item.shipping_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
    end

    it 'prefecture_idが1だと出品できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'shipping_day_idが1だと出品できない' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping day can't be blank")
    end

    it '価格が空だと出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300未満だと出品できない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の間で入力してください")
    end

    it '価格が9,999,999を超えると出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の間で入力してください")
    end

    it '価格が半角数値以外だと出品できない' do
      @item.price = 'あああ'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price は半角数値で入力してください")
    end

    it '画像が添付されていないと出品できない' do
      @item.image.detach
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it 'ユーザーが紐づいていないと出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
