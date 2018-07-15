require 'faraday'
require 'json'


class BittrexApi

  def initialize(key, secret, version='v1.1')
    @key = key
    @secret = secret
    @base_url = "https://bittrex.com/api/#{version}"
    @conn = Faraday.new(:url => @base_url)
  end

  def get_order_history
    return get('/account/getorderhistory')
  end

  def get_balances(include_zero_balances=false)
    balances = get('/account/getbalances')
    if include_zero_balances
      return balances
    else
      return balances.select do |b|
        b['Balance'] > 0
      end
    end
  end

  def get_deposit_history
    return get('/account/getdeposithistory')
  end

  def get_withdrawal_history
    return get('/account/getwithdrawalhistory')
  end


  private

  def get(endpoint, params={}, headers={})
    nonce = Time.now.to_i
    url = "#{@base_url}#{endpoint}"

    response = @conn.get do |req|
      req.params.merge!(params)
      req.url(url)
      req.params[:apikey] = @key
      req.params[:nonce] = nonce
      req.headers[:apisign] = gen_signature(url, nonce)
    end

    if response.success?
      parsed = JSON.parse(response.body)
      return parsed['result']
    else
      raise 'Sorry, something went wrong while making a Bittrex API request.'
    end
  end

  def gen_signature(url, nonce)
    return OpenSSL::HMAC.hexdigest(
      'sha512',
      @secret,
      "#{url}?apikey=#{@key}&nonce=#{nonce}"
    )
  end

end
