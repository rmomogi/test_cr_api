class Customer < ApplicationRecord
  has_many :carts

  def name=(attribute)
    write_attribute(:name, attribute.to_s.titleize)
  end
end
