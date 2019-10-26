Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'about/author'
  resources :tests do
    resources :questions, shallow: true, except: :index
  end
end
