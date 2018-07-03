class User < ApplicationRecord
    validates :tel, uniqueness: true, presence: true
    has_many :orders
    has_many :auth_tokens
    has_many :likes, counter_cache: true
    has_secure_password

    def send_pin
        self.pin = 1234
        save
        true
    end
end
