class Medicine < ApplicationRecord
  def total
    value.to_f * quantity.to_f
  end

  def decrement_stock(quantity)
    raise Exception, 'Stock not quantity to sell' if quantity > stock
    self.stock -= quantity
    save!
  end

  def increment_stock(quantity)
    self.stock += quantity
    save!
  end
end
