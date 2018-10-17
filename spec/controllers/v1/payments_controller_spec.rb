# #encoding: utf-8

# require 'spec_helper'
# RSpec.describe V1::PaymentsController, type: :controller do
#   before(:all) do
#     user = create(:user)
#     @order = create(:order, :user=>user)
#     @payment = create(:payment, :merchant_order_id=>"b4bfe695-94f9-798a-b4bf-e69500166d6e", :order=>@order)
#   end

#   it 'payment success' do
#     get :success, params: { orderId: "b4bfe695-94f9-798a-b4bf-e69500166d6e" }
#     expect(response.body).to look_like_json
#   end


# end