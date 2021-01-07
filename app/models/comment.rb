class Comment < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :post
end
