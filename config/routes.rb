Rails.application.routes.draw do
  namespace :api do
    resources :auth
    namespace :sector do
      get 'current'
    end
    namespace :player do
      get 'stats'
    end
  end
end
