require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require './models/deposit'
require './models/trade'
require './models/withdrawal'
require './binance_parser'


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

  trades = Trade.where(pair: pair)
  trades.to_json
end

get '/volume' do
  get_volume.to_json
end

get '/volume/:pair' do |pair|
  get_volume(pair).to_json
end

def get_volume(pair = nil)
  volume = {}
  if pair != nil
    trades = Trade.where(:pair => pair)
  else
    trades = Trade.all
  end

  trades.each do |trade|
    base_coin = trade.pair.chars.last(3).join
    if volume[base_coin]
      volume[base_coin] = volume[base_coin] + trade.total
    else
      volume[base_coin] = trade.total
    end
  end

  return volume
end

get '/trades' do
  trades = Trade.all
  trades.to_json
end

get '/deposits' do
  deposits = Deposit.all
  deposits.to_json
end

get '/withdrawals' do
  withdrawals = Withdrawal.all
  withdrawals.to_json
end

get '/import/trades/binance' do
  binance_parser = BinanceParser.new
  trade_folder = 'export_files/binance/trades'
  inserted_trades = []

  Dir.entries(trade_folder).each do |e|
    if e.include? '.xlsx'
      trades = binance_parser.parse_trades(trade_folder + '/' + e)
      insert_trades(trades)
      inserted_trades.concat(trades)
    end
  end

  results = { trades: inserted_trades }
  return results.to_json
end


def insert_trades(rows)
  rows.each do |row|
    trade_obj = {
      date: Date.parse(row[0]),
      pair: row[1],
      exchange: 'BINANCE',
      buy_or_sell: row[2],
      price: row[3].to_f,
      amount: row[4].to_f,
      total: row[5].to_f,
      fee: row[6].to_f,
      fee_coin: row[7]
    }
    trade = Trade.new(trade_obj)
    puts trade if trade.save?
    raise 'Error: something went wrong while attempting to insert a Trade row.' if !trade.save?
  end
end

