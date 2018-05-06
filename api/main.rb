require 'sinatra'
require './binance_trades.rb'

BINANCE_TRADES = './TradeHistory.xlsx'
binance = BinanceTrades.new(BINANCE_TRADES)

set :public_folder, '../client/build'
set :root, File.expand_path('../.')
set :views, Proc.new { File.join(root, 'client/build') }

get '/' do
  render :html, :index
end

get '/trades/pair/:pair' do |pair|
  content_type :json

  trades = binance.get_trades_by_pair(pair)
  trades.to_json
end

get '/trades/volume' do
  volume = binance.get_trade_volume()
end

get '/trades' do
  trades = binance.get_all_trades()
  trades.to_json
end

get '/trades/pairs' do
  pairs = binance.get_all_pairs()
  pairs.to_json
end

