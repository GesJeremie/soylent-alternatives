Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  # Redirect www to no-www
  if Rails.env.production?
    constraints subdomain: 'www' do
      get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
    end
  end

  root 'pages#home'

  resources :brands, only: [:index, :show], param: :slug

  resources :products, only: [:index, :show], param: :slug do
    member do
      post :vote
    end
  end

  resources :collections, only: [:index, :show], param: :slug
  resources :currencies, only: [:index, :update], param: :code
  resources :sitemap, only: [:index], constraints: { format: 'xml' }
  resource :newsletter, only: [:show, :create]

  resource :guru do
    collection do
      get '/', action: :index, as: :index
      get :allergen
      get :diet
      get :country
      get :type
      get :subscription
      get :email

      post :allergen_create
      post :diet_create
      post :country_create
      post :type_create
      post :subscription_create
      post :email_create
    end
  end

  resources :pages, only: [] do
    collection do
      get 'what-is-a-complete-food'
    end
  end
end

