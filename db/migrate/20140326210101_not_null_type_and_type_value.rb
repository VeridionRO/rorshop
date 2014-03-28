class NotNullTypeAndTypeValue < ActiveRecord::Migration
  def change
    change_column :types, :name, :string, :null => false
    change_column :type_values, :type_id, :int, :null => false
    change_column :type_values, :value, :string, :null => false
  end
end
