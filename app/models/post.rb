class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_many :likes, dependent: :delete_all
  has_many :users, through: :likes

  has_many :comments, dependent: :delete_all
end
