StatUltimate::Application.routes.draw do
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users, :only => [:new, :create, :delete, :update]

  resources :players, :only => [:show, :create, :delete, :update] do # Created from team screen
    member do
      get 'graph'
    end
  end
  resources :teams, :shallow => true do
    member do
      get 'review'
    end
    resources :games do
      member do
        get 'graph'
        get 'review'
      end
    end
  end
  resources :games, :shallow => true, :only => [:new, :create, :delete, :update, :show, :players] do
    resources :lines
    member do
      get 'players'
    end
  end
  resources :lines
    
  root :to => "root#index"

end
