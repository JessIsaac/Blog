Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'pages#home'
    get 'about', to: 'pages#about'
    
    resources :articles
    #route to singup users controller  then new action
    get 'signup', to: 'users#new'
    # two ways to create a route to the actions of users 
    #1.- create a path to submit users 
    #post 'users', to: 'users#create'
    #2.- put resources and de name of the resource 
    resources :users, except: [:new]
    #In this case we don't put the new route because we already have it
end
