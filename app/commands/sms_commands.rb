require 'net/https'
class SMSCommands
    def self.send_pin(tel, pin)
        begin
        uri = URI.parse("https://sms.ru/")
        request = Net::HTTP.new(uri.host, uri.port)
        request.use_ssl = true
        request.verify_mode = OpenSSL::SSL::VERIFY_NONE
        is_test = Rails.env.development? ? "&test=1" : ""
        response = request.get("/sms/send?api_id=#{Rails.application.secrets.sms_secret_key}&to=#{tel}&msg=Ваш+код:+#{pin}&json=1#{is_test}")
        response = JSON.parse(response.body)
        if response["sms"][tel.to_s]["status"] == "OK"
            return true
        else
            raise "error"
        end
    rescue => error
        return false
      end
    end
end