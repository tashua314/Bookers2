Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/home/about', to: 'homes#about'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get   "/users/:id/edit", to: "users#edit", as: 'edit_user'
    post  "/users/:id", to: "users#update"
    patch "/users/:id", to: "users#update"
    get   "/users/:id", to: "users#show", as: 'user'
    get   "/users", to: "users#index", as: 'users'
  end

  resources :books
end
