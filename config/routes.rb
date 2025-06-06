Rails.application.routes.draw do
  resources :pt_enrollments
  resources :peer_teachers
  resources :enrollments
  resources :courses
  resources :students
  resources :rosters do
    collection { post :import }
  end

  post "/import_pt_rosters", to: "pt_enrollments#import", as: "import_pt_rosters"

  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" },
             skip: [ :registrations ]


  devise_scope :user do
    get "users/auth/failure", to: "users/omniauth_callbacks#failure"
  end

  resources :users, only: [ :index, :new, :create, :destroy ]

  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "statistics", to: "statistics#index", as: "statistics"
  get "statistics/duplicate_students", to: "statistics#duplicate_students", as: "statistics_duplicate_students"
  get 'statistics/per_class_statistics', to: 'statistics#per_class_statistics'
  get 'statistics/na_students', to: 'statistics#na_students', as: 'statistics_na_students'

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
