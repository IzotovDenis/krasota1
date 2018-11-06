class User < ApplicationRecord
    validates :tel, uniqueness: true, presence: true
    validates :email, uniqueness: true
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

    def for_1c
        json = self.as_json(
            except: [:password_digest]
            )
        self.attributes.keys.each do |attribute|
            if self[attribute].class == ActiveSupport::TimeWithZone
                json[attribute] = self[attribute].strftime('%Y%m%d%H%M%S')
            end
        end
        json
    end

end