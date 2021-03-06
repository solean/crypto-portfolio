require 'sinatra/activerecord'

class Deposit < ActiveRecord::Base
  validates :completed, presence: true
  validates :currency, presence: true
  validates :amount, presence: true
  validates :date, presence: true
end