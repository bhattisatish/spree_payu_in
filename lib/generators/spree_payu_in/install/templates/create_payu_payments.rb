class CreatePayuPayments < ActiveRecord::Migration
  def change
    unless table_exists? :payu_payments
      create_table :payu_payments do |t|
        t.string :payment_id
        t.string :mode
        t.string :status
        t.string :key
        t.string :transaction_id
        t.float :amount
        t.string :discount
        t.text :json

        t.timestamps
      end
    end
  end
end
