class CartService
  attr_reader :cart

  def initialize(customer)
    @cart = Cart.create(customer_id: customer.id)
  end

  def add_item(medicine, quantity = 1)
    medicine.decrement_stock(quantity)
    @cart.add_cart_item(medicine, quantity)
  end

  def remove_item(medicine, quantity = 1)
    raise Exception, 'Quantity of the cart less than requested' if quantity > @cart.find_item(medicine).quantity
    medicine.increment_stock(quantity)
    @cart.remove_cart_item(medicine, quantity)
  end

  def destroy
    @cart.destroy!
  end
end
