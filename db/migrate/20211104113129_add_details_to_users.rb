class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :phone, :string
    add_column :users, :website, :string
    add_reference :users, :company, null: false, foreign_key: true
  end
end
