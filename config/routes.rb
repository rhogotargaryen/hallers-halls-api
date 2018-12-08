Rails.application.routes.draw do

  
namespace :api do
  
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'api/sessions',
               registrations: 'api/registrations',
               omniauth_callbacks: 'api/omniauth_callbacks'
             }
  resources :users, except: [:new, :edit]
  resources :items, except: [:new, :edit]
end

root to: "api/users#index"
get '/auth/facebook/callback' => 'api/sessions#create'  

end
