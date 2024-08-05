FactoryBot.define do
  factory :ecomprocessing_checkout_source, class: 'Spree::EcomprocessingCheckoutSource' do
    before(:create) do |object|
      object.payment_method = create(:ecomprocessing_checkout_gateway)
    end

    consumer_id { '123456' }
    consumer_email { 'example@example.com' }
  end
end
