Rails.application.routes.draw do
  get 'fx/index'
  get 'fx/test'
  root 'fx#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
