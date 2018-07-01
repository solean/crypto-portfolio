require 'date'
require 'roo'

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

end