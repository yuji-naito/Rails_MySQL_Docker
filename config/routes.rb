Rails.application.routes.draw do
  namespace :v1 do
    namespace :api do
      get 'samples/index'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
