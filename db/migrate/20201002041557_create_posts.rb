class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user, foreign_key: true
      t.integer :sake_brewery, foreign_key: true
      t.string :sake_name
      t.string :sake_img_id
      t.references :tag, foreign_key: true
      t.text :sake_text
      t.integer :sake_degree

      t.timestamps
    end
  end
end
