Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get('/', {to: 'home#index', as: 'root'})
  get('/about', {to: 'home#about', as: 'about'})

  get('/contacts/new', {to:'contacts#new', as: 'contacts_new'})
  post('/contacts', {to: 'contacts#create'})
  
  get('/users/panel', {to: 'users#panel', as: 'users_panel'})

  resources :products do
    resources :reviews, shallow: true, only:[:create, :destroy] do
      resources :likes, only:[:create, :destroy]
      resources :votes, only: [:create, :update, :destroy]
    end
    resources :favorites, shallow: true, only:[:create, :destroy]
  end

  resources :favorites, only: [:index]

  resources :users, only:[:new,:create]

  resource :session, only:[:new,:create, :destroy] #singlar not plural

  resources :news_articles

  # Delay_Job
  match(
    "/delayed_job",
    to: DelayedJobWeb,
    anchor:false,
    via:[:get,:post]
  )
end

