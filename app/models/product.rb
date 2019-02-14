class Product < ApplicationRecord
  has_many :photos

  accepts_nested_attributes_for :photos

  def default_photo
    photos.last
  end
end
