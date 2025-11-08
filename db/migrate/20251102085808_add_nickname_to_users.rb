class AddNicknameToUsers < ActiveRecord::Migration[7.1]
  def change
     unless column_exists?(:users, :nickname)
    add_column :users, :nickname, :string
  end
end
end
