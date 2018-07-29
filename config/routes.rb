Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :sessions

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
      post 'trade'
    end

    namespace :transactions do
      post 'offer'
    end
  end
end
