class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.where(fullfilled: false)
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    # located: app/services/payment_service.rb
    payment = PaymentService.new({
      cart: @cart,
      customer: @order.customer,
      card_number: "4242 4242 4242 4242",
      expiration_date: "02/30",
      cvc: "123"
    }).call

    respond_to do |format|
      if payment && payment.success?
        @order.confirmation = payment.payload

        if @order.save
          create_order_items

          format.html { redirect_to customers_confirmation_path(@order), notice: "Order was successfully created." }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to customers_checkout_path, notice: payment.error }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_url, notice: "Order was successfully updated." }  # <- update this link redirect to orders index page.
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer, :confirmation, :total, :fullfilled)
    end

    def create_order_items
      @order.transfer_cart_to_order_items(session[:cart_id])
      session.delete('cart_id')
    end
end
