Rails.application.routes.draw do
  namespace :v1 do
    get 'search', to: 'searches#index'
    resources :items do
      collection do
        get 'rand'
      end
    end
    resources :groups
    resources :orders do
      collection do
        post ':id/set_formed', to: 'orders#set_formed'
        post 'sync', to: 'orders#sync'
        post 'getOrderItems'
      end
    end
    resources :users do
      collection do
        post 'send_pin'
        post 'check_pin' 
        post 'sign_in'
        post 'sign_up'
        post 'init_user'
      end
    end
    resources :likes do
      collection do
        post 'set_like', to: 'likes#set_like'
        post 'del_like', to: 'likes#del_like'
      end
    end
  end

  namespace :admin do
    resources :orders do
      collection do
        post 'getOrderItems'
        get 'not_received'
        post ':id/set_received', to: 'orders#set_received'
        post ':id/set_confirmed', to: 'orders#set_confirmed'
        post 'create_rand'
      end
    end
    resources :users
  end 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
