class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user
      t.integer :post

      t.timestamps
    end
  end
end
