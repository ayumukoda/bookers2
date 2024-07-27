Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }

  root to:"homes#top"
  
  resources :users, only: [:create, :index, :show, :edit, :update]
  resources :books, only: [:create, :new, :index, :show, :edit, :update, :destroy]
  get 'home/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
