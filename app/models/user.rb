class User < ApplicationRecord
  include Discard::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  has_many :likes
  has_many :liked, through: :likes, source: :post

  has_many :comments

  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :following

  has_many :received_follows, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower
end
