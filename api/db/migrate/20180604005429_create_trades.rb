class CreateTrades < ActiveRecord::Migration[5.2]
  def self.up
    create_table :trades do |t|
      t.timestamp :date
      t.string :pair
      t.string :exchange
      t.string :buy_or_sell
      t.float :price
      t.float :amount
      t.float :total
      t.float :fee
      t.string :fee_coin
    end
  end

  def self.down
    drop_table :trades
  end
end
