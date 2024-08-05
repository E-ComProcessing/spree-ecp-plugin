module SpreeEcomprocessingGenesis
  # Engine
  class Engine < ::Rails::Engine

    require 'spree/core'
    require 'genesis_ruby'
    require 'genesis_ruby/utils/transactions/wpf_types'
    require 'genesis_ruby/utils/transactions/references/capturable_types'
    require 'genesis_ruby/utils/transactions/references/refundable_types'
    require 'genesis_ruby/utils/transactions/references/voidable_types'

    isolate_namespace Spree
    engine_name 'spree_ecomprocessing_genesis'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')).sort.each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    config.after_initialize do |app|
      app.config.spree.payment_methods += [
        Spree::Gateway::EcomprocessingDirect,
        Spree::Gateway::EcomprocessingCheckout
      ]
    end

    config.assets.precompile += %w(
      spree/ecomprocessing_threeds.js spree/ecomprocessing_threeds.css spree/ecomprocessing_logo.png
    )

  end
end
