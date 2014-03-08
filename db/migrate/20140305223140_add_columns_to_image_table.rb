class AddColumnsToImageTable < ActiveRecord::Migration
  def change
    add_column :images, :title, :string, limit: 255, null: false, after: :id
    add_column :images, :uri, :string, limit: 255, null: false, after: :title
    add_column :images, :default_img, :boolean, default: true, null: false, after: :uri
    add_index :images, [:product_id, :default_img], :unique => true
  end
end
