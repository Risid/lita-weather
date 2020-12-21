require 'net/http'

module Lita
  module Handlers
    class Weather < Handler
      # insert handler code here
      #
      config :key, required: true
      route(
          /(.*)天气.*$/,
          :respond_with_weather,
          command: true,
          help: {'北京天气' => '打印出北京现在天气'}
      )

      def query_weather(n)
        http_response = http.get(
            "https://geoapi.heweather.net/v2/city/lookup?location=#{URI::encode(n)}&key=#{config.key}"
        )
        # uri = URI()
        data = MultiJson.load(http_response.body)
        rep_code = data["code"]

        rep = data["location"]
        if rep_code == '200'

          http_response = http.get(
              "https://devapi.heweather.net/v7/weather/now?location=#{rep[0]['id']}&key=#{config.key}"
          )
          # response.reply("Lita正在获取#{n}的天气情况")
          data = MultiJson.load(http_response.body)
          rep_code = data["code"]
          if rep_code == '200'

            print_now_weather(data['now'], n)
          else
            "您可能输错了城市，Lita没有找到#{n}这个城市的天气情况"
          end
        else
          "您可能输错了城市，Lita没有找到#{n}这个城市"
        end


      end

      def respond_with_weather(response)
        n = response.match_data.captures.first

        response.reply("Lita正在找#{n}的天气情况")
        response.reply query_weather(n)
      end

      def print_now_weather(now, city)
        "#{city}现在#{now['text']}，温度#{now['temp']}摄氏度，相对湿度#{now['humidity']}%，体感温度#{now['feelsLike']}摄氏度，#{now['windDir']}"

      end


      Lita.register_handler(self)
    end
  end
end
