class V1::PaymentsController <  V1Controller
    before_action :set_payment, :only => [:success]
    def registr
        AlfaBankMerchant
    end

    def success
        if @payment
            @payment.check
            redirect_to "#{Rails.application.secrets.front_end_host}/profile/orders/#{@payment.order_id}"
        else
            redirect_to Rails.application.secrets.front_end_host
        end
    end

    def fail

    end

    private

    def set_payment
        @payment = Payment.where(:merchant_order_id=>params[:orderId]).first
    end


end