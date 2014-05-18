class AddEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string, after: :last_name
  end
end
