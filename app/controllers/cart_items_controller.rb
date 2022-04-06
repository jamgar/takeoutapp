class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ destroy ]
  before_action :set_cart, only: %i[ create destroy ]


  # POST /cart_items or /cart_items.json
  def create
    @cart_item = @cart.cart_items.new(cart_item_params)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to customers_menu_path, notice: "Item was added." }
        # format.html { redirect_to cart_cart_item_url(@cart_item), notice: "Cart item was successfully created." }
        # format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { redirect_to customers_menu_path, status: :unprocessable_entity, notice: "Item was not added. Try again." }
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1 or /cart_items/1.json
  def destroy
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_cart_items_url, notice: "Cart item was successfully destroyed." }
      format.turbo_stream # <- Notice a turbo_stream format is needed now for Rails 7
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def set_cart
      @cart = Cart.find(params[:cart_id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :menu_item_id)
    end
end