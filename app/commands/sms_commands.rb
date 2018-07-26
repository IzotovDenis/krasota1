require 'net/https'
class SMSCommands
    def self.send_pin(tel, pin)
        begin
        uri = URI.parse("https://sms.ru/")
        request = Net::HTTP.new(uri.host, uri.port)
        request.use_ssl = true
        request.verify_mode = OpenSSL::SSL::VERIFY_NONE
        response = request.get("/sms/send?api_id=#{Rails.application.secrets.sms_secret_key}&to=#{tel}&msg=Ваш+код:+#{pin}&json=1&test=1")
        response = JSON.parse(response.body)
        puts response["sms"][tel.to_s]["status"]
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