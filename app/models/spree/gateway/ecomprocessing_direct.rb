module Spree
  # Ecomprocessing Direct Payment Method
  class Gateway::EcomprocessingDirect < SpreeEcomprocessingGenesis::Base::Gateway # rubocop:disable Style/ClassAndModuleChildren

    preference :token, :string
    preference :transaction_types, :select,  default: lambda {
      { values: [:authorize, :authorize3d, :sale, :sale3d] }
    }

    delegate :load_data, :load_source, :load_payment, to: :provider

    def method_type
      SpreeEcomprocessingGenesis::PaymentMethodHelper::DIRECT_PAYMENT
    end

    def purchase(_money_in_cents, source, gateway_options)
      order, payment = order_data_from_options gateway_options
      user           = order.user

      prepare_provider(
        SpreeEcomprocessingGenesis::Mappers::Order.prepare_data(order, user, gateway_options),
        source,
        payment
      )

      provider.purchase
    end

    def source_required?
      true
    end

    def payment_source_class
      CreditCard
    end

    def auto_capture?
      !GenesisRuby::Utils::Transactions::References::CapturableTypes.all.include? options[:transaction_types]
    end

    private

    # Prepare provider
    def prepare_provider(data, source, payment)
      load_data SpreeEcomprocessingGenesis::Mappers::Order.for data
      load_source source
      load_payment payment
    end

  end
end
