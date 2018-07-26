class Smsmessage < ApplicationRecord
    def timeout
        40
    end

    def self.check_for_send(tel)
        Smsmessage.where(:tel=>tel, :used=>false).where("created_at > ?", DateTime.now-60.seconds).last
    end

    def self.check_for_enter(tel)
        Smsmessage.where(:tel=>tel, :used=>false).where("created_at > ?", DateTime.now-3600.seconds).last
    end

    def self.create_pin(tel)
        pin = rand.to_s[2..7]
        if SMSCommands.send_pin(tel, pin)
            Smsmessage.create(:tel=>tel, :pin=>pin)
            return true
        else
            return false
        end
    end

    def self.send_pin(tel)
        pin = Smsmessage.check_for_send(tel)
        if pin
            return {success: true, time: (60-(Time.now-pin.created_at)).to_i}
        else
            if Smsmessage.create_pin(tel)
                return { success: true, time: 60}
            else
                return { success: false }
            end
        end 
    end

    def set_used
        self.used = true
        save
    end

    def self.verify_pin(tel, pin)
        @last_pin = Smsmessage.check_for_enter(tel)
            if @last_pin && @last_pin.pin == pin
                if @last_pin.set_used
                    return true
                else
                    return false
                end
            else
                return false
            end
    end
    
end
