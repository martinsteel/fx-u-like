Rails.application.routes.draw do
  get 'conversion/index'
  post 'conversion/index', to: 'conversion#convert'
  root 'conversion#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
