require 'date'
require 'roo'

class BinanceParser

  def parse_trades(path)
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
    else
      raise 'Invalid path. A Binance trade history file should be an .xlsx spreadsheet.'
    end
  end

  def parse_deposits(path)
    if path.end_with? '.csv'
      csv = Roo::CSV.new(path)
      return csv.parse
    else
      raise 'Invalid path. Parser is expecting a .csv file.'
    end
  end

  def parse_withdrawals(path)
    if path.end_with? '.csv'
      csv = Roo::CSV.new(path)
      return csv.parse
    else
      raise 'Invalid path. Parser is expecting a .csv file.'
    end
  end

end
