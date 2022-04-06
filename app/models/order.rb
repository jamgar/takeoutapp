class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  validates :customer, presence: true

  def transfer_cart_to_order_items(cart_id)
    cart = Cart.find(cart_id)
    cart.cart_items.each do |item|
      OrderItem.create(order_id: self.id, menu_item_id: item.menu_item_id)
    end

    broadcast_append_to "orders"

    cart.cart_items.delete_all
    cart.delete
  end
end
