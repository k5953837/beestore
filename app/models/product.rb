class Product < ApplicationRecord
  has_many :photos
  accepts_nested_attributes_for :photos

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :photos, presence: true
  validates :discount, presence: true, inclusion: { in: 1..100, message: 'must be between 1 & 100' }

  def default_photo
    photos.last
  end

  def premium_price
    (original_price - ( discount.to_f / 100 * price )).ceil
  end

  def original_price
    price
  end
end
