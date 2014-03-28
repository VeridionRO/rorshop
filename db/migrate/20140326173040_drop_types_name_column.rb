class DropTypesNameColumn < ActiveRecord::Migration
  def change
    remove_column :types, :type
  end
end
