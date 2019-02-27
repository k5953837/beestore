class Product < ApplicationRecord
  has_one :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :discount, presence: true, inclusion: { in: 1..100, message: 'must be between 1 & 100' }
  validates_associated :photo

  def premium_price
    (original_price - ( discount.to_f / 100 * price )).ceil
  end

  def original_price
    price
  end
end
