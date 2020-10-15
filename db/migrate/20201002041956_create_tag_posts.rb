class CreateTagPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_posts do |t|
      t.integer :tag, foreign_key: true
      t.integer :post, foreign_key: true

      t.timestamps
    end
  end
end
