class PayuPayment < ActiveRecord::Base
  has_many :payments, :as => :source
  
  def self.new_from(params)
    PayuPayment.new(
    :payment_id=> params['mihpayid'],
    :mode => params['mode'],
    :status => params['status'],
    :key => params['key'],
    :transaction_id=> params['tnxid'],
    :amount => BigDecimal.new(params['amount']).to_f,
    :discount=> params['discount'],
    :json=> params.to_json) 
  end
  
  def process!(payment)
  end
end