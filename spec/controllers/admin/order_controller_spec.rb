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
        expect(@json["order"]['amount']).to eq(600)
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

