RSpec.describe Spree::EcomprocessingThreedsController, :vcr, type: :controller do
  describe 'when invalid params' do
    it 'with proper response body' do
      get :index, params: { unique_id: 'invalid', checksum: 'invalid' }

      expect(response.body).to eq 'Error during Ecomprocessing 3DSv2 execution. Contact administrator!'
    end

    it 'with proper response code' do
      get :index, params: { unique_id: 'invalid', checksum: 'invalid' }

      expect(response).to have_http_status :ok
    end
  end

  describe 'with valid params' do
    let(:payment) do
      create :spree_payment,
             payment_method: create(:ecomprocessing_direct_gateway),
             source: create(:credit_card_params)
    end
    let(:order) do
      order = OrderWalkthrough.up_to(:payment)

      order.payments << payment

      order
    end
    let(:ecomprocessing_payment) do
      create :ecomprocessing_direct_payment,
             status:         'pending_async',
             amount:         99,
             currency:       'EUR',
             order_id:       order.number,
             payment_id:     payment.number
    end
    let(:params) do
      {
        unique_id: ecomprocessing_payment.unique_id,
        checksum:  Digest::MD5.hexdigest(
          "#{ecomprocessing_payment.unique_id}#{ecomprocessing_payment.major_amount}#{ecomprocessing_payment.currency}"
        )
      }
    end

    it 'with proper template' do
      get :index, params: params

      expect(response).to render_template(:method_continue)
    end

    it 'with enabled iframe' do
      get :index, params: params

      expect(response.headers).to_not include 'X-Frame-Options'
    end
  end
end
