class WelcomeController < ApplicationController
  def test
  	response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=28805,us&units=imperial&appid=#{ENV['openweather_api_key']}")
  	@location = response['name']
  	@temp = response['main']['temp']
  	@weather_icon = response['weather'][0]['icon']
  	@weather_words = response['weather'][0]['description']
  	@cloudiness = response['clouds']['all']
  	@windiness = response['wind']['speed']
  end

  def index
    if params[:zipcode] != '' && !params[:zipcode].nil?
          response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=#{params[:zipcode]},us&units=imperial&appid=#{ENV['openweather_api_key']}")
          @status = response['cod']

          if @status != '404' && response['message'] != 'city not found'
                @location = response['name']
                @temp = response['main']['temp']
                @weather_icon = response['weather'][0]['icon']
                @weather_words = response['weather'][0]['description']
                @cloudiness = response['clouds']['all']
                @windiness = response['wind']['speed']
          else
            @error = response['message']
          end
    end
  end
end
