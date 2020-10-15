class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :sake_brewery_id
      t.string :sake_name
      t.string :sake_img_id
      t.integer :tag_id
      t.text :sake_text
      t.integer :sake_degree

      t.timestamps
    end
  end
end
