class Order < ApplicationRecord
    attr_accessor :items_1c
    belongs_to :user
    has_one :payment
    scope :for_admin, -> {select(:id, :amount, :items_count, :user_id, :created_at, :formed, :formed_at, :received, :received_at, :info)}
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

    def full_items
        keys = self.items.keys
        items = Item.where("id IN (?)", keys)
        amount = 0
        ordered_items = []
        items.each do |item|
            qty = self.items[item.id.to_s]["qty"].to_i
            ordered_items.push({id: item.id, code: item.code ,title: item.title, price: item.price, qty: qty, image: item.image})
        end
        ordered_items
    end

    def full_order
        order = {}
        order['id'] = self.id
        order['amount'] = self.amount
        order['items'] = self.full_items
        order['formed_at'] = self.formed_at
        order['info'] = self.info
        order['is_paid'] = false
        order
    end


    def as_json
        hash = {}
        self.attributes.keys.each do |key|
            if self.attributes[key].class.to_s == 'ActiveSupport::TimeWithZone'
                hash[key] = self.attributes[key].strftime('%Y%M%d%H%M%S')
            else
                hash[key] = self.attributes[key]
            end
        end
        hash
    end

    
    def pay
        if self.formed
            payment = Payment.where(:order=>self).first
            if payment
                return payment
            else
                response = AlfaBankMerchant.registr(self.id, amount, self.formed_at+3.days)
                logger.debug(response)
                if response && response['orderId']
                    payment = Payment.create(:order=>self, :amount=>self.amount, :merchant_order_id=>response['orderId'], :order_url=>response['formUrl'])
                else
                    self.errors.add(:base, 'some error')
                end
            end
        else
            self.errors.add(:base, 'not formed')
            return false
        end
    end

end
