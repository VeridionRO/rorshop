class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :product, index: true
      t.string :title
      t.string :uri
      t.boolean :default, default: true

      t.timestamps
    end
  end
end
