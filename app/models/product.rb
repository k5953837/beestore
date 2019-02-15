class Product < ApplicationRecord
  has_many :photos

  accepts_nested_attributes_for :photos

  def default_photo
    photos.last
  end

  def premium_price
    (self.price.to_f * 0.8).to_i
  end

  def original_price
    self.price
  end
end
