class CreateSakeBreweries < ActiveRecord::Migration[5.2]
  def change
    create_table :sake_breweries do |t|
      t.string :brewery_name
      t.integer :brewery_prefecture
      t.text :brewery_address

      t.timestamps
    end
  end
end
