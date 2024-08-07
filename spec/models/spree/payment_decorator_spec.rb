RSpec.describe Spree::Payment do
  let(:spree_payment) do
    source = create(:spree_credit_card)
    create(:spree_payment, payment_method: source.payment_method, source: source)
  end
  let(:create_ecomprocessing_payment) do
    create(
      :ecomprocessing_payment,
      payment_method: spree_payment.payment_method.name,
      payment_id:     spree_payment.number,
      order_id:       spree_payment.order.number,
      amount:         GenesisRuby::Utils::MoneyFormat.amount_to_exponent(
        spree_payment.amount.to_s, spree_payment.currency
      ),
      currency:       spree_payment.order.currency
    )
  end

  describe 'when empty data' do
    it 'with proper response' do
      expect(spree_payment.ecomprocessing_payments).to be_empty
    end
  end

  describe 'when data' do
    it 'when ecomprocessing_payments with proper response' do
      create_ecomprocessing_payment

      expect(spree_payment.ecomprocessing_payments).to be_a ActiveRecord::Relation
    end

    it 'when ecomprocessing_payments with proper data' do
      ecomprocessing_payment = create_ecomprocessing_payment

      expect(spree_payment.ecomprocessing_payments.first.transaction_id).to eq ecomprocessing_payment.transaction_id
    end
  end

  describe 'when non ecomprocessing source' do
    let(:payment_method) { create(:credit_card_payment_method) }
    let(:source_attributes) do
      {
        payment_method_id: payment_method.id,
        source_attributes: {
          gateway_payment_profile_id: 'card_1JqvNB2eZvKYlo2C5OlqLV7S'
        }
      }
    end

    it 'with credit card source' do
      payment = described_class.new source_attributes

      expect(payment.source).to be_a Spree::CreditCard
    end
  end
end
