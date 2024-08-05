FactoryBot.define do
  factory :ecomprocessing_payment, class: 'SpreeEcomprocessingGenesis::Db::EcomprocessingPayment' do
    transaction_id { Faker::Internet.uuid }
    unique_id { Faker::Internet.uuid }
    reference_id { Faker::Internet.uuid }
    terminal_token { Faker::Internet.uuid }
    status { 'approved' }
    transaction_type { 'authorize3d' }
    mode { 'test' }
    response { { timestamp: DateTime.now } }
  end

  factory :ecomprocessing_direct_payment,
          parent: :ecomprocessing_payment,
          class: 'SpreeEcomprocessingGenesis::Db::EcomprocessingPayment' do
    payment_method { Spree::Gateway::EcomprocessingDirect }
  end

  factory :ecomprocessing_checkout_payment,
          parent: :ecomprocessing_payment,
          class: 'SpreeEcomprocessingGenesis::Db::EcomprocessingPayment' do
    payment_method { Spree::Gateway::EcomprocessingCheckout }
  end
end
