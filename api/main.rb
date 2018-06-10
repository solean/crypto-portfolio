require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require './models/trade'


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
  get_volume.to_json
end

get '/volume/:pair' do |pair|
  get_volume(pair).to_json
end

def get_volume(pair=nil)
  volume = Hash.new
  if pair != nil
    trades = Trade.where(:pair => pair)
  else
    trades = Trade.all
  end

  trades.each do |trade|
    baseCoin = trade.pair.chars.last(3).join
    if volume[baseCoin]
      volume[baseCoin] = volume[baseCoin] + trade.total
    else
      volume[baseCoin] = trade.total
    end
  end
end

get '/trades' do
  trades = Trade.all
  trades.to_json
end
