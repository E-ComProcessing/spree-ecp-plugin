# 3DSv2 Callback Status field DB migration
class AddCallbackStatusToEcomprocessingPayments < ActiveRecord::Migration[6.1]

  def change
    add_column :ecomprocessing_payments, :callback_status, :string
  end

end
