class AlfaBankMerchant
    class << self

        require 'net/http'
        #require 'uri'

        def prepare_fields(fields = {})
        fields['userName'] = Rails.application.secrets.alfa_user_name
        fields['password'] = Rails.application.secrets.alfa_password
        fields['returnUrl'] = Rails.application.secrets.alfa_return_url
        fields['failUrl'] = Rails.application.secrets.alfa_fail_url
        fields.map{|k,v| "#{k}=#{v}"}.join('&')
        end



        def registr(order_id, amount, date_valid)
            endpoint = 'https://web.rbsuat.com/ab/rest/register.do?'
            fields = {
                'orderNumber': "test213#{order_id.to_s}",
                'amount': amount.to_s,
                'expirationDate': (date_valid-7.hours).strftime("%Y-%m-%dT%H:%M:%S")
            }

            params = AlfaBankMerchant.prepare_fields(fields)
            url = endpoint+params
            uri = URI(url)
            request(uri)
        end

        def request(uri)
            begin 
                Rails.logger.debug(uri)
                result = Net::HTTP.start(uri.host, uri.port,
                :use_ssl => uri.scheme == 'https') do |http|
                request = Net::HTTP::Get.new uri
                response = http.request request
                end
                result = JSON.parse(result.body)
                if (result['errorCode'] != nil )
                    return {success: false, result: result }
                else 
                    return {success: true, result: result}
                end
            rescue
                raise
                return {success: false}
            end
        end

        def deposit(merchant_order_id)
            endpoint = 'https://web.rbsuat.com/ab/rest/getOrderStatusExtended.do?'
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
                if (result['errorCode'] != "0")
                    return {success: false, errorCode: result['errorCode'], result: result }
                else 
                    return {success: true, result: result}
                end
            rescue
                raise
                error = true
                return {success: false}
            end
        end

        def check_payment(merchant_order_id)
            result = deposit(merchant_order_id)
            if result[:success]
                response = prepare_answer(result)
            else
                result
            end
            response
        end

        def prepare_answer(result)
            response = {}
            if result[:result]["orderStatus"] == 2
                begin
                response[:is_paid] = true
                response[:paid_at] = DateTime.strptime(result[:result]["authDateTime"].to_s,'%Q').change(:offset=>"+1000")+10.hours
                response[:result] = result[:result]
                rescue
                response[:is_paid] = false
                response[:error] = true
                end
            else 
                response[:is_paid] = false
            end
            response
        end

    end
end