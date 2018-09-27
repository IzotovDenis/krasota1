class AlfaBankMerchant
    class << self

        require 'net/http'
        #require 'uri'

        def prepare_fields(fields = {})
        fields['userName'] = Rails.application.secrets.alfa_user_name
        fields['password'] = Rails.application.secrets.alfa_password
        fields.map{|k,v| "#{k}=#{v}"}.join('&')
        end

        def registr(order_id, amount, date_valid)
            puts "date_valid"
            endpoint = 'https://web.rbsuat.com/ab/rest/register.do?'
            fields = {
                'orderNumber': "test#{order_id.to_s}",
                'amount': amount*100.to_s,
                'returnUrl': 'http://xn--25-6kca2czamjk.xn--p1ai/',
                'failUrl': 'http://xn--25-6kca2czamjk.xn--p1ai/',
                'expirationDate': date_valid.strftime("%Y-%m-%dT%H:%M:%S")
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
                    return result
                else 
                    return result
                end
            rescue
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