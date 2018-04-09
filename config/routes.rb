Rails.application.routes.draw do
  resources :reviews do
    get 'finish', on: :collection
  end
end
