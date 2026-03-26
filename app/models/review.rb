class Review < ApplicationRecord
  MIN_LEVEL = 0
  MAX_LEVEL = 5
  belongs_to :restaurant
  validates :content, :rating, presence: true
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: MIN_LEVEL,
    less_than_or_equal_to: MAX_LEVEL
  }
end
