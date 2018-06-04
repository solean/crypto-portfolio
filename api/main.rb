require 'sinatra'
require 'sinatra/activerecord'
require './environments'
# require './binance_trades.rb'
# require './parse_to_db'
require './models/trade'

BINANCE_TRADES = './TradeHistory.xlsx'
# binance = BinanceTrades.new(BINANCE_TRADES)

set :public_folder, '../client/build'
set :root, File.expand_path('../.')
set :views, Proc.new { File.join(root, 'client/build') }

get '/' do
  render :html, :index
end

get '/trades/:id' do
  Trade.find_by_id(params[:id])
end

get '/trades/pair/:pair' do |pair|
  content_type :json

  trades = Trade.where(:pair => pair)
  trades.to_json
end

get '/volume' do
  volume = Hash.new
  trades = Trade.all
  puts trades
  trades.each do |trade|
    baseCoin = trade.pair.chars.last(3).join
    if volume[baseCoin]
      volume[baseCoin] = volume[baseCoin] + trade.total
    else
      volume[baseCoin] = trade.total
    end
  end
  volume.to_json
end

get '/trades' do
  trades = Trade.all
  trades.to_json
end

