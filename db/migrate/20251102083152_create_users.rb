class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Devise に必要なカラム
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## プロフィール用カラム（以前のAddProfileToUsersから引き継ぎ）
      t.string :nickname, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_read, null: false
      t.string :first_name_read, null: false
      t.date   :birthday, null: false

      t.timestamps null: false
    end

    ## インデックス（Deviseで推奨）
    add_index :users, :email, unique: true
  end
end

