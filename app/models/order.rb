class Order < ApplicationRecord
    attr_accessor :items_1c
    belongs_to :user
    scope :for_admin, -> {select(:id, :amount, :items_count, :user_id, :created_at, :formed, :formed_at, :received, :received_at)}
    scope :not_received, -> {where(received: false)}
    scope :formed, -> {where(formed: true).order("formed_at DESC")}

    def set_received
        self.received = true
        self.received_at = DateTime.now
        self.save
    end

    def set_formed
        order = {}
        keys = self.items.keys
        items = Item.where("id IN (?)", keys)
        amount = 0
        items.each do |item|
            qty = self.items[item.id.to_s]["qty"].to_i
            order[item.id] = {id: item.id, uid: item.uid, price: item.price, qty: qty}
            amount += qty*item.price
        end
        self.items = order
        self.amount = amount
        self.items_count = items.count
        self.formed = true
        self.formed_at = DateTime.now
        self.save
    end

    def for_1c
        items = []
        keys = self.items.keys
        keys.each do |i|
            items.push(self.items[i])
        end
        items
    end

    def as_json
        hash = {}
        self.attributes.keys.each do |key|
            if self.attributes[key].class.to_s == 'ActiveSupport::TimeWithZone'
                hash[key] = self.attributes[key].to_i
            else
                hash[key] = self.attributes[key]
            end
        end
        hash
    end
    
end
