class Post < ApplicationRecord
   belongs_to :sake_brewery
   accepts_nested_attributes_for :sake_brewery #１つのform_forでsake_breweryモデルも保存するため
  # belongs_to :tag
  belongs_to :user
   has_many :likes, dependent: :destroy

  attachment :sake_img
  validates :sake_name, presence: true, length: { maximum: 20 }
  validates :sake_text, presence: true, length: { maximum: 140 }
  # validates :sake_img_id, presence: true

  def liked_by?(user)
  	likes.where(user_id: user.id).exists?
  end

end
