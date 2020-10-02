class Post < ApplicationRecord
  # belongs_to :sake_brewery
  # belongs_to :tag
  belongs_to :user

  attachment :sake_img
  validates :sake_name, presence: true, length: { maximum: 20 }
  validates :sake_text, presence: true, length: { maximum: 140 }
end
