class V1::PaymentsController <  V1Controller
    before_action :set_payment, :only => [:success]
    def registr
        AlfaBankMerchant
    end

    def success
        render json: @payment.check
    end

    def fail

    end

    private

    def set_payment
        @payment = Payment.where(:merchant_order_id=>params[:orderId]).first
    end


end