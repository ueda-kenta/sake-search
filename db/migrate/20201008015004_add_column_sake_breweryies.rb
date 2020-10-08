class AddColumnSakeBreweryies < ActiveRecord::Migration[5.2]
  def change
  	add_column :sake_breweries, :latitude, :float
  	add_column :sake_breweries, :longitude, :float
  end
end
