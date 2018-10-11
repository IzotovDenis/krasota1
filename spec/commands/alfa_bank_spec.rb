# require 'rails_helper'

# RSpec.describe AlfaBankMerchant do
#     before(:all) do
#         @payment_order_id = "b4bfe695-94f9-798a-b4bf-e69500166d6e"
#         @not_payment_order_id = "b71d4394-daca-787c-b71d-439400166d6e"
#     end

#     it 'payments success' do
#         payment_result = AlfaBankMerchant.check_payment(@payment_order_id)
#         expect(payment_result[:is_paid]).to eq(true)
#         expect(payment_result[:paid_at].class).to eq(DateTime)
#     end

#     it 'unpayment order not paid' do
#         payment_result = AlfaBankMerchant.check_payment(@not_payment_order_id)
#         expect(payment_result[:is_paid]).to eq(false)
#     end

# end
