class RenameNameReadToKanaInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :last_name_read, :last_name_kana
    rename_column :users, :first_name_read, :first_name_kana
  end
end
