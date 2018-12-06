Rails.application.routes.draw do

namespace :api do
  resources :users, except: [:new, :edit]
  resources :items, except: [:new, :edit]
end

get '/auth/facebook/callback' => 'sessions#create'  
get '/logout' => 'sessions#destroy'

end
