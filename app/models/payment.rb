class Payment < ApplicationRecord
    belongs_to :order

    def check
        response = AlfaBankMerchant.deposit(self.merchant_order_id)
        puts response
    end

end
