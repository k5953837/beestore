class AddDiscountToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :discount, :integer
  end
end
