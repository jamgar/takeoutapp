class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def total
    cart_items.map { |i| i.menu_item.price }.sum
  end
end
