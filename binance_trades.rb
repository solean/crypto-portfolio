require 'roo'

# Columns:
#   Date - 2017-12-30 20:11:45
#   Market - STRATBTC
#   Type - BUY/SELL
#   Price - 0.001003
#   Amount - 52.68
#   Total - 0.00021
#   Fee - 0.0000002
#   Fee Coin - STRAT

class ExcelParser

  def initialize
  end

  def parse(file_path)
    if file_path.end_with? '.xlsx'
      spreadsheet = Roo::Spreadsheet.open(file_path)
      file = spreadsheet.sheet(0)

      # 0 is blank, 1 is the row of headers, 2 is the first row of data
      i = 2
      rows = []
      while i < file.last_row
        rows.push(file.row(i))
        i += 1
      end

      return rows
    end
  end
end

class BinanceTrades < ExcelParser
  attr_accessor :trades

  def initialize(file_path)
    @trades = parse(file_path)
  end
end

# ex = ExcelParser.new
# history = ex.parse('./TradeHistory.xlsx')
# puts history[0]

bnc = BinanceTrades.new('./TradeHistory.xlsx')
puts bnc.trades[0]