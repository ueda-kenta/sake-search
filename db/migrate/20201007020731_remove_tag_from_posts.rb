class RemoveTagFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :posts, :tag, foreign_key: true
  end
end
