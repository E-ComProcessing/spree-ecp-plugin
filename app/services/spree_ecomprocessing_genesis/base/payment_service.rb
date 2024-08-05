module SpreeEcomprocessingGenesis
  module Base
    # Payment Service Base class
    class PaymentService

      attr_reader :params, :ecomprocessing_payment, :order, :spree_payment, :genesis_provider

      # Constructor
      def initialize(params)
        # Alignment that suits plugin generation
        @params = params
        @ecomprocessing_payment = fetch_emerchantapy_payment
        @order = load_order
        @spree_payment = load_spree_payment
        @genesis_provider = initialize_genesis_provider
      end

      protected

      # Fetch ecomprocessing payment
      def fetch_emerchantapy_payment
        result = wpf_params? ? load_wpf_payment : load_processing_payment

        raise 'Invalid parameters given. Payment not found.' unless result

        result
      end

      # Load the Order using the payment
      def load_order
        SpreeEcomprocessingGenesis::SpreeOrderRepository.find_by_number @ecomprocessing_payment[:order_id]
      end

      # Load the Spree Payment record
      def load_spree_payment
        @order.payments.find_by(number: @ecomprocessing_payment[:payment_id])
      end

      # Initialize the payment provider
      def initialize_genesis_provider
        provider = GenesisProvider.new(
          PaymentMethodHelper.fetch_method_type(@ecomprocessing_payment.payment_method),
          genesis_preferences
        )
        provider.load_source spree_payment.source
        provider.load_data SpreeEcomprocessingGenesis::Mappers::Order.for order.attributes.symbolize_keys
        provider.load_payment spree_payment

        provider
      end

      # Check 3DSv2 request against the given signature
      def validate_3ds_signature
        raise 'Invalid 3DS signature' unless @params[:signature] == generate_3ds_signature
      end

      # Generate 3DSv2 signature
      def generate_3ds_signature
        GenesisRuby::Utils::Threeds::V2.generate_signature(
          unique_id:         ecomprocessing_payment.unique_id,
          amount:            ecomprocessing_payment.amount,
          timestamp:         ecomprocessing_payment.zulu_response_timestamp,
          merchant_password: genesis_preferences[:password]
        )
      end

      # Generate Checksum
      def generate_checksum
        TransactionHelper.generate_checksum(
          {
            unique_id: ecomprocessing_payment.unique_id,
            amount:    ecomprocessing_payment.major_amount,
            currency:  ecomprocessing_payment.currency
          }
        )
      end

      private

      # Prepare Genesis Preferences
      def genesis_preferences
        @spree_payment.payment_method.preferences.merge token: @ecomprocessing_payment[:terminal_token]
      end

      # Load Processing payment via params[:unique_id]
      def load_processing_payment
        EcomprocessingPaymentsRepository.find_by_unique_id params[:unique_id]
      end

      # Load WPF initial or reference payment
      def load_wpf_payment
        # WPF Initial transaction case
        result = EcomprocessingPaymentsRepository.find_by_unique_id params[:wpf_unique_id]

        return result if result

        return nil unless params.key? :payment_transaction_unique_id

        # WPF Reference transaction notifications
        EcomprocessingPaymentsRepository.find_by_unique_id params[:payment_transaction_unique_id]
      end

      # Fetch the parameters type
      def wpf_params?
        params.key? :wpf_unique_id
      end

    end
  end
end
