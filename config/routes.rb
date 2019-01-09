Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
             }
  
namespace :api do
  resources :users, except: [:new] do 
    resources :items, only: [:show, :edit, :index]
  end
  resources :items, except: [:new]
end

root to: "api/users#index"

end
