class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :medicine

  before_create :default_values

  private

  def default_values
    self.quantity = 0
  end
end
