class User < ApplicationRecord
    validates :email, uniqueness: true
    validates :tel, uniqueness: true, presence: true
    has_many :orders
    has_secure_password

    def send_pin
        true
    end
end
