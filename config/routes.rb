Rails.application.routes.draw do
  namespace :api do
    resources :auth
    namespace :sector do
      get 'current'
    end
    namespace :player do
      get 'stats'
    end
    namespace :ports do
      get 'query/:id', action: :query
    end
  end
end
