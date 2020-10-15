class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      # t.references :follow, type: :integer, foreign_key: { to_table: :users }
      t.integer :follow_id
      t.timestamps

      t.index [:user_id, :follow_id], unique: true
    end
  end
end
