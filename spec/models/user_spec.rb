require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '登録できるとき' do
    it 'すべての項目が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '登録できないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailに@がないと登録できない' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下では登録できない' do
      @user.password = 'a1b2'
      @user.password_confirmation = 'a1b2'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英数字混合でないと登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
    end

    it 'last_nameが全角でないと登録できない' do
      @user.last_name = 'Yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name は全角で入力してください')
    end

    it 'last_name_readがカタカナでないと登録できない' do
      @user.last_name_read = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name read は全角カタカナで入力してください')
    end

    it 'birthdayが空では登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it 'emailが重複していると登録できない' do
      @user.save
      another = FactoryBot.build(:user, email: @user.email)
      another.valid?
      expect(another.errors.full_messages).to include('Email has already been taken')
    end
  end
end

