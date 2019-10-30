Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :reports

  get 'reports' => 'reports#index'
  get 'reports/:id' => 'reports#show'
  post 'reports' => 'reports#create'
  put 'reports/:id' => 'reports#update'
  delete 'reports/:id' => 'reports#destroy'

end
