class Weather < OpenStruct
  def self.current(city)
    city = city.downcase
    key = "weather:#{city}"

    weather = Rails.cache.read(key)
    return weather if weather

    weather = get_weather_in(city)
    Rails.cache.write(key, weather, expires_in: 1.week)
    weather
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}"

    response = HTTParty.get "#{url}&query=#{ERB::Util.url_encode(city)}"
    weather = response.parsed_response["current"]

    return nil unless weather

    Weather.new weather
  end

  def self.key
    return nil if Rails.env.test? # testatessa ei apia tarvita, palautetaan nil
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
