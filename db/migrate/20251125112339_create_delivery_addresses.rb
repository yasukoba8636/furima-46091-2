class CreateDeliveryAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_addresses do |t|
      t.references :order, null: false, foreign_key: true
      t.string :postal_code
      t.integer :prefecture_id
      t.string :municipality
      t.string :address
      t.string :building
      t.string :phone

      t.timestamps
    end
  end
end
