class Discount < ApplicationRecord
  belongs_to :merchant

  validates :discount_rate, numericality: { less_than: 0.71 }
end
