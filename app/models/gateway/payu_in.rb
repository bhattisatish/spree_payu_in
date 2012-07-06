class Gateway::PayuIn < Gateway
  preference :merchant_id, :string
	preference :salt, :string
	preference :url, :string
  
  def provider_class
		PayuInGateway
  end	

  def payment_page_url(order)
    payu_in_payment_url(order)
  end
  
  def external_payment_url
    self.url
  end
end
