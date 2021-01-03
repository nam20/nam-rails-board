class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_many :comments
end
