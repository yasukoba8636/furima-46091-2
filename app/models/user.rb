class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  VALID_FULL_WIDTH_NAME = /\A[ぁ-んァ-ン一-龥々]+\z/

  VALID_KATAKANA = /\A[ァ-ヶー]+\z/

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

  validates :password, format: { with: VALID_PASSWORD, message: "は半角英数字混合で入力してください" }, allow_nil: true
end
