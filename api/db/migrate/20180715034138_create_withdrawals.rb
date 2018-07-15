class CreateWithdrawals < ActiveRecord::Migration[5.2]
  def self.up
    create_table :withdrawals do |w|
      w.boolean :completed
      w.string :currency
      w.float :amount
      w.timestamp :date
      w.string :address
      w.string :txid
    end
  end

  def self.down
    drop_table :withdrawals
  end
end
