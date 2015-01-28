require 'net/http'
require 'json'

class ApiSender

    def initialize(url,key,sensors)
        puts "Initializing Api Sender to #{url}"
        @url = url
        @key = key
        @sensors = sensors
        @alive = true
        @interval = 5.0
        @thread= Thread.new{self.propagate()}    
        @timeout = 10
    end

    def propagate
        puts "Posting.."
        while @alive

            uri = URI.parse(@url+"/api/sensors_update")
            postData = Net::HTTP.post_form(uri, {'key'=>@key, 'sensors'=>JSON.generate(@sensors)})

            if postData.code == "200"
                puts "posted"
            else

                puts "error #{postData.code}"
            end
            sleep @interval
        end

    end

    def stop
        puts "Stoping sender"
        @alive = false
        @thread.join
    end
end
