class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォロー関連
  has_many :relationships, dependent: :nullify
  has_many :followings, through: :relationships, source: :follow # follow_idを使ってfollowingにアクセス
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  attachment :profile_img

  validates :last_name, presence: true, length: { maximum: 8 }
  validates :first_name, presence: true, length: { maximum: 8 }
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :profile_text, length: { maximum: 140 }

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship # if relationship exists? relationship.destroyと同義
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  # ゲストユーザーの記述
  def self.guest
    User.find_or_create_by!(last_name: 'ゲスト', first_name: 'たろう', nickname: 'ゲスト', email: 'guest@example.com', profile_text: 'ゲストユーザーです。ゲストの投稿は1日ごとにリセットされます。') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # 検索機能
  def self.search(search, word)
    @user = case search
            when 'perfect_match'
              User.where('nickname', word.to_s)
            when 'partial_match'
              User.where('nickname LIKE?', "%#{word}%")
            else
              User.all
            end
  end
end
