class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true
  default_scope -> { order(id: :desc) }
end
