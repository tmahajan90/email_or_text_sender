require "razorpay"

class PaymentsController < ApplicationController
    before_action :set_razorpay_key
    protect_from_forgery except: :verify
  
    def new
        @key = Rails.application.credentials.razorpay[:key_id]
        @order_id = SecureRandom.uuid
        @amount = 12400  # Amount in paisa (e.g., 50000 paisa = 500 INR)
        @razorpay_order = Razorpay::Order.create(amount: @amount, currency: 'INR', receipt: @order_id)
    end
  
    def create
    end
  
    def callback
        razorpay_payment_id = params[:razorpay_payment_id]
        razorpay_order_id = params[:razorpay_order_id]
        razorpay_signature = params[:razorpay_signature]
    
        # Verify the payment signature to ensure it's valid
        if verify_payment_signature(razorpay_order_id, razorpay_payment_id, razorpay_signature)
          # Payment is successful, handle success logic here
          # e.g., mark payment as completed, update order status, etc.
          flash[:notice] = "Payment was successful."
        else
          # Payment verification failed
          flash[:alert] = "Payment verification failed."
        end
    
        redirect_to root_path
    end

    private

    def verify_payment_signature(order_id, payment_id, signature)
        generated_signature = OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new('sha256'),
          Rails.application.credentials.razorpay[:key_secret],
          "#{order_id}|#{payment_id}"
        )
    
        generated_signature == signature
      end

    def set_razorpay_key
        Razorpay.setup(Rails.application.credentials.razorpay[:key_id], Rails.application.credentials.razorpay[:key_secret])
    end
  end
  