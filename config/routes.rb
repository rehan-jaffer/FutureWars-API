Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :sessions
    resources :ships

    namespace :player do
      get 'stats'
      post 'move'
    end

   namespace :scanners do
     get 'density/:id', action: :density
   end

   namespace :nav do
   
      post 'warp'
      get 'warp_path/:id', action: :warp_path
      post 'express_warp'

      namespace :sector do
        get 'current'
        get 'view/:id', action: :view
      end

   end

   namespace :subspace do

      namespace :corporations do
        post 'create'
        post 'join'
        post 'leave'
      end

      namespace :messages do
        post 'send'
        get 'read'
        get 'list'
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
end
