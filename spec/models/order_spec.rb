require 'rails_helper'

RSpec.describe Order, type: :model do
    before(:all) do
        @item = create(:item, :in_stock=>3)
        @item2 = create(:item, :in_stock=>7)
        @empty_item = create(:item, :in_stock=>0)
        @order_list = {@item.id.to_s => 2, @empty_item.id.to_s=> 3, @item2.id.to_s => 40}
        @order = build(:order, :order_list=>@order_list )
    end

    it '.avaiable_items' do
        expect(@order.avaiable_items.length).to eq(2)
    end

    it '.unavaiable_items' do
        expect(@order.unavaiable_items.length).to eq(1)
    end

    it '.pre_amount' do
        expect(@order.pre_amount).to eq(900)
    end

    it 'items == avaiable_items' do
        expect(@order.items.length).to eq(2)
    end

    it 'not empty order is valid' do
        item = create(:item, :in_stock=>3)
        item2 = create(:item, :in_stock=>7)
        empty_item = create(:item, :in_stock=>0)
        order_list = {item.id.to_s => 2, empty_item.id.to_s=> 3, item2.id.to_s => 40}
        order = build(:order, :order_list=>order_list )
        expect(order.is_valid?).to eq(true)
    end

    it 'order with item not in stock is not valid' do
        order_list = {@empty_item.id.to_s=>3}
        order = build(:order, :order_list=>order_list )
        expect(order.is_valid?).to eq(false)
    end

    it 'empty order is not valid' do
        order = build(:order)
        expect(order.is_valid?).to eq(false)
    end



end
