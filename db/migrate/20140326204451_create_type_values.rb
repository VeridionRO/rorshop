class CreateTypeValues < ActiveRecord::Migration
  def change
    create_table :type_values do |t|
      t.references :type
      t.string :value

      t.timestamps
    end
  end
end
