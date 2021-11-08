class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :suite
      t.string :city
      t.string :zipcode
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
