class Tag < ApplicationRecord
  has_many :tag_posts, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :tag_posts
end
