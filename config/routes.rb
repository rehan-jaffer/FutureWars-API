Rails.application.routes.draw do
  namespace :api do
    resources :auth
    namespace :sector do
      get 'current'
      get 'view/:id', action: :view
    end
    namespace :player do
      get 'stats'
      post 'move'
    end
    namespace :ports do
      get 'query/:id', action: :query
    end
  end
end
