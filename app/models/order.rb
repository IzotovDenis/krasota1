class Order < ApplicationRecord
    attr_accessor :items_1c
    attr_accessor :order_list
    attr_accessor :rate
    after_initialize :set_items
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
        self.formed = true
        self.formed_at = DateTime.now
        self.save
    end

    def avaiable_items
        if self.order_list
            ids = self.order_list.keys || []
            @items = Item.where("id IN (?)", ids).where('in_stock > 0').with_stock.with_discount(self.rate)
            @items.map {|item| item.in_stock.to_f >= self.order_list[item.id.to_s].to_f ? item.ordered=self.order_list[item.id.to_s] : item.ordered=item.in_stock; item.as_json }
        else
            []
        end
    end

    def pre_amount
        amount = 0
        self.avaiable_items.map {|item| amount+=item['ordered'].to_i*item['price'].to_i}
        amount
    end

    def unavaiable_items
        if self.order_list
            ids = self.order_list.keys  || []
            @items = Item.where("id IN (?)", ids).where('in_stock <= 0').with_stock
        else
            []
        end
    end

    def is_valid?
        self.avaiable_items.length > 0
    end

    def set_paid(time)
        self.is_paid = true
        self.paid_at = time
        self.payable = false
        save
    end

    def for_1c
        self.items
    end

    def full_items
        keys = self.items.keys
        items = Item.where("id IN (?)", keys)
        amount = 0
        ordered_items = []
        items.each do |item|
            qty = self.items[item.id.to_s]["qty"].to_i
            ordered_items.push({id: item.id, uid: item.uid, code: item.code ,title: item.title, price: item.price, qty: qty, image: item.image})
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
    
    def pay
        if self.formed
            payment = Payment.where(:order=>self).first
            if payment
                return payment
            else
                response = AlfaBankMerchant.registr(self.id, amount, self.formed_at+3.days)
                logger.debug(response)
                if response[:success]
                    payment = Payment.create(:order=>self, :amount=>self.amount, :merchant_order_id=>response[:result]['orderId'], :order_url=>response[:result]['formUrl'])
                else
                    self.errors.add(:payment, 'оплата по карте не доступна')
                    return false
                end
            end
        else
            self.errors.add(:base, 'not formed')
            return false
        end
    end


     def set_items
        if self.new_record?
            if !self.rate
                self.rate = 1
            end
            self.items = self.avaiable_items
            self.amount = self.pre_amount
            self.items_count = self.items.count
        end
     end

end
