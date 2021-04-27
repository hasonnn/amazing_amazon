Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get('/', {to: 'home#index', as: 'root'})
  get('/about', {to: 'home#about', as: 'about'})

  get('/contacts/new', {to:'contacts#new', as: 'contacts_new'})
  post('/contacts', {to: 'contacts#create'})
  
  get('/users/panel', {to: 'users#panel', as: 'users_panel'})

  resources :products do
    resources :reviews, only:[:create, :destroy]
  end

  resources :users, only:[:new,:create]

  resource :session, only:[:new,:create, :destroy] #singlar not plural

  resources :news_articles
end

