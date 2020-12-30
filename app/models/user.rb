class User < ApplicationRecord
  has_secure_password
  has_many :posts

  has_many :likes
  has_many :posts, through: :likes

  has_many :comments
end
