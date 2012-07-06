Rails.application.routes.draw do
  resources :orders do
    resource :checkout, :controller=>"checkout" do
      member do
        get :payu_in_checkout
        get :payu_in_payment
        get :payu_in_confirm
        get :payu_in_finish
      end
    end
  end

  match "/payment_confirmed" => "checkout#gateway_callback", :method => :post, :as=> 'payment_callback'

  namespace :admin do
    resources :orders do
      resources :payu_in_payments, :member => {:capture => :get, :refund => :any}, :has_many => [:txns]
    end
  end
end
