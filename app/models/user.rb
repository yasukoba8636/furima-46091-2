class User < ApplicationRecord
  # Deviseの基本モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ===========================
  # 正規表現
  # ===========================
  # 全角（漢字・ひらがな・カタカナ）
  VALID_FULL_WIDTH_NAME = /\A[ぁ-んァ-ン一-龥々]+\z/
  # 全角カタカナ（長音符「ー」含む）
  VALID_KATAKANA = /\A[ァ-ヶー]+\z/
  # 半角英数字混合（英字+数字が最低1つずつ）
  VALID_PASSWORD = /\A(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]+\z/

  # ===========================
  validates :nickname, presence: true 
  # ===========================
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: VALID_FULL_WIDTH_NAME, message: "は全角で入力してください" }
  validates :first_name, presence: true, format: { with: VALID_FULL_WIDTH_NAME, message: "は全角で入力してください" }
  validates :last_name_kana, presence: true, format: { with: VALID_KATAKANA, message: "は全角カタカナで入力してください" }
  validates :first_name_kana, presence: true, format: { with: VALID_KATAKANA, message: "は全角カタカナで入力してください" }
  validates :birthday, presence: true

  # パスワードの英数字混合
  validates :password, format: { with: VALID_PASSWORD, message: "は半角英数字混合で入力してください" }, allow_nil: true
end
