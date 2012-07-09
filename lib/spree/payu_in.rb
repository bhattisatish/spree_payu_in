require 'bigdecimal'

module Spree::PayuIn
  include ERB::Util
  include ActiveMerchant::RequiresParameters


  def self.included(target)
    target.skip_before_filter :verify_authenticity_token, :only=> [:gateway_callback]
  end

  def before_payment_options
    payment_method = Spree::PaymentMethod.find_by_type('Spree::Gateway::PayuIn')
    @gateway = payment_method.provider
    render 'checkout/payment_options'
  end

  def payu_checkout
    load_order
    gateway = payment_method.provider
    redirect_to gateway.payment_page_url(@order)
  end

  def payu_in_payment
    load_order
    payment_method = Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
    @gateway = payment_method.provider
    render "checkout/edit"
  end

  def object_params
    params[:order]
  end

  def gateway_callback
    @order = Spree::Order.find(params[:txnid])
    if params[:status] == 'failed'
      payment_method = Spree::PaymentMethod.find(params['udf1'])
      flash[:notice] = "Payment processing failed. Please choose a different payment option, or try again."
      @gateway = payment_method.provider
      render 'checkout/failed'
    elsif params[:status] == 'canceled'
      flash[:notice] = "You cancelled payment. Please choose a different payment option, or try again."
      payment_method = Spree::PaymentMethod.find(params['udf1'])
      @gateway = payment_method.provider
      render 'checkout/failed'
    else
      puts "Payment successful. payu_in_notify:#{params.inspect}"
      payment = @order.payments.create(:amount => BigDecimal.new(params["amount"]),
                                                :source => Spree::PayuPayment.new_from(params),
                                                :payment_method_id => params['udf1'])

      @order.state = 'payment'
      if @order.next
        state_callback(:after)
      else
        flash[:error] = I18n.t(:payment_processing_failed)
        respond_with(@order, :location => checkout_state_path(@order.state))
        return
      end

      if @order.state == "complete" || @order.completed?
        flash[:notice] = I18n.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        respond_with(@order, :location => completion_route)
      else
        respond_with(@order, :location => checkout_state_path(@order.state))
      end
    end
  end

  def completion_route
    order_path(@order, :checkout_complete=>true)
  end

  private
  def payment_method
    Spree::PaymentMethod.find(params[:payment_method_id])
  end
end
