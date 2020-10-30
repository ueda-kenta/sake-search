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

  # idの昇順にモデルで指定
  default_scope -> { order(id: :desc) }

  def liked_by?(user)
  	likes.where(user_id: user.id).exists?
  end

  def save_posts(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << post_tag
    end
  end

  def self.create_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def self.search(search,word)
    if search == "perfect_match"
      @posts = Post.where("sake_name LIKE?","#{word}")
    elsif search == "partial_match"
      @posts = Post.where("sake_name LIKE?","%#{word}%")
    else
      @posts = Post.all
    end
  end
end