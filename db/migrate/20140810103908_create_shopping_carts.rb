class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.references :user, index: true
      t.date :delivered_on
      t.text :comments

      t.timestamps
    end
  end
end
