#encoding: utf-8

require 'spec_helper'
RSpec.describe Admin::OrdersController, type: :controller do
    before(:all) do
        @user = create(:user)
        item = create(:item)
        item2 = create(:item)
        order_list = {item.id.to_s=> item.in_stock.to_i, item2.id.to_s=> item2.in_stock.to_i}
        @order = create(:formed_order, :user=> @user, :order_list=>order_list)
    end

    before(:each) do
        get :show, params: { id: @order.id }
        @json = JSON.parse(response.body)
    end

    it 'correct order id' do
        expect(@json["order"]['id']).to eq(@order.id)
    end

    it 'correct order items' do
        expect(@json["order"]['items']).to eq(@order.items)
    end

    it 'correct order amount' do
        expect(@json["order"]['amount']).to eq(@order.amount)
    end

    it 'correct order formed' do
        expect(@json["order"]['formed']).to eq(@order.formed)
    end

    it 'correct user' do
        expect(@json["order"]['user']['id']).to eq(@user.id)
    end

    it 'correct formed_at' do
        expect(@json["order"]['formed_at']).to eq("20181004031538")
    end

end

RSpec.describe Admin::OrdersController, type: :controller do
    before(:all) do
        @user = create(:user)
        item = create(:item)
        item2 = create(:item)
        order_list = {item.id.to_s=> item.in_stock.to_i, item2.id.to_s=> item2.in_stock.to_i}
        @order = create(:formed_order, :user=> @user, :order_list=>order_list)
    end

    before(:each) do
        get :show, params: { id: @order.id }
        @json = JSON.parse(response.body)
    end

    it 'formed order not paid' do
        expect(@json["order"]["is_paid"]).to eq(false)
    end

    it 'formed order is payable' do
        expect(@json["order"]['payable']).to eq(true)
    end

end

RSpec.describe Admin::OrdersController, type: :controller do
    before(:all) do
        @user = create(:user)
        item = create(:item)
        item2 = create(:item)
        order_list = {item.id.to_s=> item.in_stock.to_i, item2.id.to_s=> item2.in_stock.to_i}
        @order = create(:formed_order, :user=> @user, :order_list=>order_list)
        create(:formed_order, :user=> @user, :order_list=>order_list, :is_paid=>true)
        create(:order, :user=> @user, :order_list=>order_list)
        
    end

    it 'show all orders' do
        get :index
        @json = JSON.parse(response.body)
        expect(@json["orders"].length).to eq(3)
    end

    it 'show only formed orders' do
        get :index, params: { formed: true }
        @json = JSON.parse(response.body)
        expect(@json["orders"].length).to eq(2)
    end

    it 'show only is_paid=true orders' do
        get :index, params: { is_paid: true }
        @json = JSON.parse(response.body)
        expect(@json["orders"].length).to eq(1)
    end

    it 'show only is_paid=true orders' do
        get :index, params: { received: true }
        @json = JSON.parse(response.body)
        expect(@json["orders"].length).to eq(0)
    end


    it 'show only is_paid=true orders' do
        expect(Order.find(@order.id).received_at).to eq(nil)
        patch :update, params: { id: @order.id, order:{ received: true } }
        @json = JSON.parse(response.body)
        expect(@json["success"]).to eq(true)
        get :index, params: { received: true }
        @json = JSON.parse(response.body)
        expect(@json["orders"].length).to eq(1)
    end

    it 'can update payable' do
        patch :update, params: { id: @order.id, order:{ payable: false } }
        @json = JSON.parse(response.body)
        expect(@json["order"]["payable"]).to eq(false)
    end


end