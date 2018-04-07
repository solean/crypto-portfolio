
class Trade

  def initialize(date, pair, exchange, buy_or_sell, price, amount, total, fee, fee_coin)
    @date = date
    @pair = pair
    @exchange = exchange
    @buy_or_sell = buy_or_sell
    @price = price
    @amount = amount
    @total = total
    @fee = fee
    @fee_coin = fee_coin
  end

end