class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :grade
      t.string :name
      t.integer :amount
      t.timestamps null: false
    end

    create_table :user_gifts do |t|
      t.integer :user_id
      t.integer :gift_id
    end

  end
end
