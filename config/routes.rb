Rails.application.routes.draw do
  namespace :api do
    resources :auth
    namespace :player do
      get 'stats'
    end
  end
end
