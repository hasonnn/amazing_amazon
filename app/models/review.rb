class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :rating, presence:{message: 'Please enter ratings.'}, numericality: {greater_than_or_equal_to: 1, lesser_than_or_equal_to: 5}

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
