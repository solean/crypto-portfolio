class CreateDeposits < ActiveRecord::Migration[5.2]
  def self.up
    create_table :deposits do |d|
      d.boolean :completed
      d.string :currency
      d.float :amount
      d.timestamp :date
      d.string :address
      d.string :txid
    end
  end

  def self.down
    drop_table :deposits
  end
end
