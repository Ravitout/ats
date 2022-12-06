class AddCalumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role_id, :integer
    add_column :users, :status, :integer, default: 0, null:false
  end
end
