require './excel_parser'

# Columns:
#   Date - 2017-12-30 20:11:45
#   Market - STRATBTC
#   Type - BUY/SELL
#   Price - 0.001003
#   Amount - 52.68
#   Total - 0.00021
#   Fee - 0.0000002
#   Fee Coin - STRAT
class BinanceTrades < ExcelParser
  attr_accessor :trades

  def initialize(file_path)
    @trades = parse(file_path)
  end

  def get_trade_volume()
    return @trades.reduce(0) do |sum, trade|
      total = trade[5].to_f
      sum += total
    end
  end
end
