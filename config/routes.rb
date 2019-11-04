Rails.application.routes.draw do
  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  root to: 'tests#index'

  get 'sessions/new'
  get 'users/new'

  # get :signup, to: 'users#new'
  # get :login, to: 'sessions#new'
  # delete :logout, to: 'sessions#destroy'

  # resources :users, only: :create
  # resources :sessions, only: :create

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'about/author'
  resources :tests, only: :index do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    post :start, on: :member
    # member do
    #   post :start
    # end
  end

  # GET /test_passages/:id/result
  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end

  namespace :admin do
    resources :tests do
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
  end
end
