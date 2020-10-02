class Post < ApplicationRecord
  belongs_to :sake_brewery
  belongs_to :tag
end
