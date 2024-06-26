Rails.application.routes.draw do
  root to:"questions#index"
  resources :questions, only: %i[index new create show edit update destroy] do
    resources :answers, only: %i[create destroy], shallow: true
  end
  resource :profiles
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # get 'tops/index'

  get '/terms_of_service', to: 'tops#terms_of_service'
  get '/privacy_policy', to: 'tops#privacy_policy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? #letter openerへのルーティング

  # Defines the root path route ("/")
  # root "posts#index"
end
