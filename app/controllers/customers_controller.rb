class CustomersController < ApplicationController
  before_action :set_cart, only: %i[ menu checkout ]

  def index
  end

  def menu
    @menu_items = MenuItem.where(available: true)
    @appetizers = MenuItem.available_appetizers
    @entrees = MenuItem.available_entrees
    @drinks = MenuItem.available_drinks
  end

  def checkout
    @order = Order.new
  end

  def confirmation 
    @order = Order.find(params[:id])
  end

  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end
