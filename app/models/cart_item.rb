class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :medicine

  before_create :default_values

  def total
  	self.quantity * medicine.value.to_f
  end

  private

  def default_values
    self.quantity = 0
  end
end
