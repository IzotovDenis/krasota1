#encoding: utf-8

require 'spec_helper'
RSpec.describe V1::OrdersController, type: :controller do
    before(:all) do
        @item = create(:item, :in_stock=>3)
        @item2 = create(:item, :in_stock=>7)
        @empty_item = create(:item, :in_stock=>0)
        @order_list = {@item.id.to_s => 2, @empty_item.id.to_s=> 3, @item2.id.to_s => 40}
    end

  it 'group look like json' do
    get :getOrderItems, params: { items: @order_list }
    expect(response.body).to look_like_json
  end

  it 'correct order amount' do
    get :getOrderItems, params: { items: @order_list }
    json = JSON.parse(response.body)
    expect(json['amount']).to eq(900)
  end

  it 'correct order is valid' do
    get :getOrderItems, params: { items: @order_list }
    json = JSON.parse(response.body)
    expect(json['valid']).to eq(true)
  end

  it 'empty order is not valid' do
    get :getOrderItems
    json = JSON.parse(response.body)
    expect(json['valid']).to eq(false)
  end

  it 'order is not valid after items in_stock=0' do
    #build items with in_stock
    item = create(:item, :in_stock=>3)
    item2 = create(:item, :in_stock=>7)
    #end
    #build item with in_stock=0
    empty_item = create(:item, :in_stock=>0)
    #end
    #order list with item witch in stock
    order_list = {item.id.to_s => 2, empty_item.id.to_s=> 3, item2.id.to_s => 40}
    #end
    get :getOrderItems, params: { items: order_list }
    json = JSON.parse(response.body)
    expect(json['valid']).to eq(true)
    #items stock is end
    item.in_stock=0
    item.save
    item2.in_stock=0
    item2.save
    #end
    get :getOrderItems, params: { items: order_list }
    json = JSON.parse(response.body)
    expect(json['valid']).to eq(false)
  end


  it 'order success formed' do
    user = create(:user)
    token = create(:auth_token, :user=>user)
    get :create, params: { items: @order_list, token: token.val }
    json = JSON.parse(response.body)
    puts json
    expect(json['success']).to eq(true)
  end

end