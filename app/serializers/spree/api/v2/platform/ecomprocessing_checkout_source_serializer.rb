module Spree
  module Api
    module V2
      module Platform
        # Ecomprocessing Checkout Source Serializer
        class EcomprocessingCheckoutSourceSerializer < BaseSerializer

          include ResourceSerializerConcern

          belongs_to :payment_method
          belongs_to :user

        end
      end
    end
  end
end
