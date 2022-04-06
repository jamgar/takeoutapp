# Simulate a payment gateway service
class PaymentService
  def initialize(params)
    @cart             = params[:cart]
    @customer         = params[:customer]
    @card_number      = params[:card_number]
    @expiration_date  = params[:expiration_date]
    @cvc              = params[:cvc]
  end

  def call
    if process_order
      OpenStruct.new(success?: true, payload: confirmation)
    else
      OpenStruct.new(success?: false, error: "Payment process was unsuccessful. Try again.")
    end
  end

  def process_order
    # Change to false if you want to simulate a failed payment
    true
  end

  def confirmation
    SecureRandom.alphanumeric
  end
end