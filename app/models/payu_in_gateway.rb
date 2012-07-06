require 'digest/sha2'

class PayuInGateway
  def initialize(hash)
    @opts = hash
  end
  
  def external_payment_url
    "#{@opts[:url]}/_payment.php"
  end
  
  def merchant_id
    @opts[:merchant_id]
  end

  def salt
    @opts[:salt]
  end
  
  def hash(order, payment_method_id)
    Digest::SHA512.hexdigest("#{self.merchant_id}|#{order.id}|#{order.total.to_i}|#{order.number}|#{order.bill_address.firstname}|#{order.user.email}|#{payment_method_id}||||||||||#{self.salt}")
  end
end