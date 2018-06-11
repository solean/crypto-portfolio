require 'date'
require 'roo'
require './models/trade'

class BinanceTradeParser
  def parse_excel(path)
    if path.end_with? '.xlsx'
      spreadsheet = Roo::Spreadsheet.open(path)
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

  def insert(rows)
    rows.each do |row|
      puts row[0]
      trade = Trade.new({
        :date => Date.parse(row[0]),
        :pair => row[1],
        :exchange => row[2],
        :buy_or_sell => row[3],
        :price => row[4].to_f,
        :amount => row[5].to_f,
        :total => row[6].to_f,
        :fee => row[7].to_f,
        :fee_coin => row[8]
      })

      if trade.save
        puts trade
      else
        puts 'error'
      end
    end
  end

end


p = Parser.new
rows = p.parse_excel('./TradeHistory.xlsx')
p.insert(rows)