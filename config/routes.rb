Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    post 'answer', to: 'answer#questions'
    get 'search_subject/:subject_id', to: 'search#subject', as:'search_subject'
  end
  namespace :profiles__backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' ##Dashbooard
    resources :admins
    resources :subjects
    resources :questions
  end
  devise_for :profiles
  devise_for :admins
  get 'site/welcome/index'
  
  root to: 'site/welcome#index'
end
