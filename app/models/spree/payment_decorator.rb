module Spree
  # Spree Payment Decorator
  module PaymentDecorator

    # Query all Genesis Gateway Payments
    def ecomprocessing_payments
      SpreeEcomprocessingGenesis::EcomprocessingPaymentsRepository.find_all_by_order_and_payment order.number, number
    end

    # Monkey patch for Ecomprocessing Checkout Source
    # see https://github.com/spree/spree/issues/981
    def build_source
      return unless new_record?

      if default_ecomprocessing_checkout_source?
        # Code format that suit plugin generation
        self.source_attributes = SpreeEcomprocessingGenesis::
            PaymentMethodHelper.default_checkout_source_attributes order
      end

      build_default_source if can_build_source?
    end

    private

    # Check if ecomprocessing checkout source should be build with the default source_attributes
    def default_ecomprocessing_checkout_source?
      payment_method.is_a?(Spree::Gateway::EcomprocessingCheckout) && !source_attributes.present?
    end

    # Check if can build source
    def can_build_source?
      source_attributes.present? && source.blank? && payment_method.try(:payment_source_class)
    end

    # Default Spree build source logic
    def build_default_source
      self.source = payment_method.payment_source_class.new(source_attributes)
      source.payment_method_id = payment_method.id
      source.user_id = order.user_id if order
    end

  end
end

::Spree::Payment.prepend(Spree::PaymentDecorator)
