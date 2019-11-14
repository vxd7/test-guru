Rails.application.routes.draw do
  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }, controllers: { sessions: 'sessions' }

  root to: 'tests#index'

  get 'sessions/new'
  get 'users/new'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'about/author'
  resources :tests, only: :index do
    post :start, on: :member
  end

  # GET /test_passages/:id/result
  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  # index is for all avaliable badges in the system
  resources :badges, only: :index do
    # user_badges is for user's personal badge collection
    get :user_badges
  end

  namespace :admin do
    resources :tests do
      # Change test title inline in table
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    # Show all gists only for admin
    resources :gists, only: :index

    resources :badges, shallow: true
  end
end
