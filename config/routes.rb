Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    post 'answer', to: 'answer#questions'
    get 'search_subject/:subject_id', to: 'search#subject', as:'search_subject'
  end
  namespace :profiles__backoffice do
    get 'welcome/index'
    get 'profile', to: 'perfil#edit'
    patch 'profile', to: 'perfil#update'
  end
  namespace :admins_backoffice do
    get 'welcome/index' ##Dashbooard
    resources :admins
    resources :subjects
    resources :questions
  end
  devise_for :profiles do
    get '/profiles/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :admins do
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end
  get 'site/welcome/index'

  get 'admin', to: 'admins_backoffice/welcome#index'
  
  root to: 'site/welcome#index'
end
