RSpec.describe Spree::Api::V2::Platform::EcomprocessingCheckoutSourceSerializer do
  let(:user) { create(:user) }
  let(:payment_method) { create(:ecomprocessing_checkout_gateway) }
  let(:source) do
    source                   = create(:ecomprocessing_checkout_source)
    source.user_id           = user.id
    source.payment_method_id = payment_method.id

    source
  end

  it 'when serialize' do
    serializer = described_class.new source

    expect(serializer.to_json).to include '"data":'
  end

end
