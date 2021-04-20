Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get('/', {to: 'home#index', as: 'root'})
  get('/about', {to: 'home#about', as: 'about'})

  get('/contacts/new', {to:'contacts#new', as:'contacts_new'})
  post('/contacts', {to: 'contacts#create'})

  resources :products do
    resources :reviews, only:[:create, :destroy]
  end
end

