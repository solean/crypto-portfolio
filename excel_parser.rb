require 'roo'

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
