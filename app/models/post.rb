class Post < ApplicationRecord
   belongs_to :sake_brewery
   accepts_nested_attributes_for :sake_brewery #１つのform_forでsake_breweryモデルも保存するため
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

  def save_tags(tag_list)
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(tag_name: tag)
        begin
          self.tags.create!(tag_name: tag)
        rescue
          nil
        end
      else
        ArticleTagRelation.create!(article_id: self.id, tag_id: find_tag.id)
      end
    end
    
  end

end
