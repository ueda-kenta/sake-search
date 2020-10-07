class Post < ApplicationRecord
   belongs_to :sake_brewery
   accepts_nested_attributes_for :sake_brewery #１つのform_forでsake_breweryモデルも保存するため
   has_many :tag_posts, dependent: :destroy
   has_many :tags, through: :tag_posts
   accepts_nested_attributes_for :tag
   belongs_to :user
   has_many :likes, dependent: :destroy
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

  def save_posts(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    #old_tagを削除
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag_name:old_tag)
    end
    # new_tagを追加
    new_tags.each do |new_tag|
      new_post_tag = Tag.find_or_create_by(tag_name:new_tag)
      self.post_tags << new_post_tag
    end


  end

end
