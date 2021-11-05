class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :catch_phrase
      t.text :bs

      t.timestamps
    end
  end
end
