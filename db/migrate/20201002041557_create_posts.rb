class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user
      t.integer :sake_brewery
      t.string :sake_name
      t.string :sake_img_id
      t.references :tag
      t.text :sake_text
      t.integer :sake_degree

      t.timestamps
    end
  end
end
