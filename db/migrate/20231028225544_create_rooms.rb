class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :description, null: false 
      t.integer :capacity
      t.decimal :price
      
      t.timestamps
    end
  end
end
