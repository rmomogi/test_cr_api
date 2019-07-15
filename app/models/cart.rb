class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items

  before_destroy :update_stock_from_destroy

  def add_cart_item(medicine, quantity)
    cart_item = find_item(medicine)
    cart_item.quantity += quantity
    cart_item.save!
  end

  def remove_cart_item(medicine, quantity)
    cart_item = find_item(medicine)
    cart_item.quantity -= quantity
    cart_item.save!
    cart_item.destroy! if cart_item.quantity == 0
  end

  def find_item(medicine)
    cart_items.find_or_create_by(medicine_id: medicine.id)
  end

  private

  def update_stock_from_destroy
    cart_items.each do |cart_item|
      remove_item(cart_item.medicine, cart_item.quantity)
    end
  end
end
