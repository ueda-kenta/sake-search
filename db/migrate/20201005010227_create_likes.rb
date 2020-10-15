class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user, foreign_key: true
      t.integer :post, foreign_key: true

      t.timestamps
    end
  end
end
