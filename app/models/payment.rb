class Payment < ApplicationRecord
    belongs_to :order

    def check
        response = AlfaBankMerchant.check_payment(self.merchant_order_id)
        if response[:is_paid]
            self.info = response[:result]
            self.save
            self.order.set_paid(response[:paid_at])
        end
        response
    end

end
