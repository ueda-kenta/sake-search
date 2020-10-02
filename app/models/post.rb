class Post < ApplicationRecord
  # belongs_to :sake_brewery
  # belongs_to :tag
  belongs_to :user

  attachment :sake_img
end
