class Post < ApplicationRecord
   belongs_to :sake_brewery
   accepts_nested_attributes_for :sake_brewery #１つのform_forでsake_breweryモデルも保存するため
  # belongs_to :tag
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts
  has_many :comments, dependent: :destroy

  attachment :sake_img
  validates :sake_name, presence: true, length: { maximum: 20 }
  validates :sake_text, presence: true, length: { maximum: 140 }
  # validates :sake_img_id, presence: true
  
  # idの昇順にモデルで指定
  default_scope -> { order(id: :desc) }

  def liked_by?(user)
  	likes.where(user_id: user.id).exists?
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.post_tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_by(tag_name: new)
      self.post_tags << new_post_tag
    end
  end

end
