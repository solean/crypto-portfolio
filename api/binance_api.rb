require 'httparty'

class BinanceApi
  include HTTParty
  base_uri 'https://api.binance.com/api/v1'

  def initialize
  end

  def ping()
    self.class.get('/ping')
  end

  def ticker(symbol)
    self.class.get('/ticker')
  end
end

api = BinanceApi.new()
puts api.ping()