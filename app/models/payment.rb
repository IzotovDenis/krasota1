class Payment < ApplicationRecord
    belongs_to :order

    def check
        response = AlfaBankMerchant.check_payment(self.merchant_order_id)
        if response[:is_paid]
            order = self.order
            order.is_paid = true
            order.payable = false
            order.save
        end
        response
    end

end
