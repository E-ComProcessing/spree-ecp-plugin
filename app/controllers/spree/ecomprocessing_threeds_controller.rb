module Spree
  # 3DSv2 Secure Method Continue customer controller
  class EcomprocessingThreedsController < ApplicationController

    after_action :allow_iframe, only: :index

    layout 'spree/method_continue'

    def index
      service = SpreeEcomprocessingGenesis::Threeds::MethodContinue.call permitted_params

      render 'method_continue', locals: service.build_secure_method_params
    rescue StandardError => e
      Rails.logger.error "Ecomprocessing Threeds Controller: #{e.message}"

      render plain: 'Error during Ecomprocessing 3DSv2 execution. Contact administrator!'
    end

    private

    # Allow iFrame execution
    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end

    def permitted_params
      params.permit :unique_id, :checksum
    end

  end
end
