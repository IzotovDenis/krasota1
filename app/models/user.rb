class User < ApplicationRecord
    validates :tel, uniqueness: true, presence: true
    has_many :orders
    has_many :auth_tokens
    has_many :likes, counter_cache: true
    has_many :smsmessages
    has_secure_password

    def send_pin
        self.pin = rand.to_s[2..7]
        self.save
        if SMSCommands.send_pin(self.tel, self.pin)
            return true
        else
            return false
        end
    end
end