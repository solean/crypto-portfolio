require 'sinatra/activerecord'

class Trade < ActiveRecord::Base
  validates :date, presence: true
  validates :pair, presence: true
  validates :exchange, presence: true
  validates :buy_or_sell, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :total, presence: true
  validates :fee, presence: true
  validates :fee_coin, presence: true
end