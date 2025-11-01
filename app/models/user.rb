class User < ApplicationRecord
  # Devise modules: 必要に応じて追加
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 正規表現
  # 全角（漢字・ひらがな・カタカナ）: 名字/名前のチェック
  VALID_FULL_WIDTH_NAME = /\A[ぁ-んァ-ン一-龥々]+\z/
  # 全角カタカナ（長音符「ー」含む）
  VALID_KATAKANA = /\A[ァ-ヶー]+\z/
  # パスワード：半角英数字混合（英字+数字が最低1つずつ）
  VALID_PASSWORD = /\A(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]+\z/

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: VALID_FULL_WIDTH_NAME, message: "は全角で入力してください" }
  validates :first_name, presence: true, format: { with: VALID_FULL_WIDTH_NAME, message: "は全角で入力してください" }
  validates :last_name_read, presence: true, format: { with: VALID_KATAKANA, message: "は全角カタカナで入力してください" }
  validates :first_name_read, presence: true, format: { with: VALID_KATAKANA, message: "は全角カタカナで入力してください" }
  validates :birthday, presence: true

  # Devise のデフォルトで password 必須・6文字以上・confirmation がチェックされるが、さらに英数混合を強制する
  validates :password, format: { with: VALID_PASSWORD, message: "は半角英数字混合で入力してください" }, allow_nil: true
end

