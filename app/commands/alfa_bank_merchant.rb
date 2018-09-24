class AlfaBankMerchant
    class << self

        require 'net/http'
        #require 'uri'

        def prepare_fields(fields = {})
        fields['userName'] = Rails.application.secrets.alfa_user_name
        fields['password'] = Rails.application.secrets.alfa_password
        fields.map{|k,v| "#{k}=#{v}"}.join('&')
        end

        def registr(order_id, order_number, amount)
            endpoint = 'https://web.rbsuat.com/ab/rest/register.do?'
            fields = {
                'orderNumber': order_number.to_s,
                'amount': amount.to_s,
                'returnUrl': 'http://192.168.0.101:3000/v1/payments/success',
                'failUrl': 'http://192.168.0.101:3000/v1/payments/fail',
                'description': "order is #{order_id}"
            }
            params = AlfaBankMerchant.prepare_fields(fields)
            url = endpoint+params
            uri = URI(url)
            begin 
                result = Net::HTTP.start(uri.host, uri.port,
                :use_ssl => uri.scheme == 'https') do |http|
                request = Net::HTTP::Get.new uri
                response = http.request request # Net::HTTPResponse object
                end
                result = JSON.parse(result.body)
                if (result['errorCode'])
                    error = true
                else 
                    return result
                end
            rescue
                puts 'someError'
                raise
                error = true
            end
        end

        def deposit(merchant_order_id)
            endpoint = 'https://web.rbsuat.com/ab/rest/getOrderStatus.do?'
            fields = {
                'orderId': merchant_order_id,
            }
            params = AlfaBankMerchant.prepare_fields(fields)
            url = endpoint+params
            uri = URI(url)
            begin 
                result = Net::HTTP.start(uri.host, uri.port,
                :use_ssl => uri.scheme == 'https') do |http|
                request = Net::HTTP::Get.new uri
                response = http.request request # Net::HTTPResponse object
                end
                result = JSON.parse(result.body)
                if (result['errorCode'])
                    error = true
                else 
                    return result
                end
            rescue
                puts 'someError'
                raise
                error = true
            end
        end
    end
end