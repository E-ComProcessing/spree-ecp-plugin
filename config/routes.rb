Spree::Core::Engine.routes.draw do
  get 'ecomprocessing_threeds/:unique_id/:checksum' => :index, controller: :ecomprocessing_threeds,
      as: :ecomprocessing_threeds_form

  namespace :api do
    namespace :v2 do
      namespace :storefront do

        post 'ecomprocessing_notification' => :index, controller: :ecomprocessing_notification,
             as: :ecomprocessing_notification

        post 'ecomprocessing_threeds/status' => :callback_handler, controller: :ecomprocessing_threeds,
             as: :ecomprocessing_threeds_callback_handler

        get 'ecomprocessing_threeds/status/:unique_id' => :callback_status, controller: :ecomprocessing_threeds,
            as: :ecomprocessing_threeds_callback_status

        post 'ecomprocessing_threeds/method_continue' => :method_continue, controller: :ecomprocessing_threeds,
             as: :ecomprocessing_threeds_secure_continue

      end
    end
  end
end
