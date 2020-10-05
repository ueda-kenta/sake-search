class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
   has_many :likes, dependent: :destroy
  attachment :profile_img

  validates :last_name, presence: true, length: { maximum: 8 }
  validates :first_name, presence: true, length: { maximum: 8 }
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :profile_text, presence: true, length: { maximum: 140 }
end
