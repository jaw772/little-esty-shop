class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :discount_rate
      t.integer :threshold_quantity
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
