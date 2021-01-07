class Post < ApplicationRecord
  include Discard::Model

  has_one_attached :image

  belongs_to :user

  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_many :comments

  after_discard do
    comments.discard_all
  end

  after_undiscard do
    comments.undiscard_all
  end
end
