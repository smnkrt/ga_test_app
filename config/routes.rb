Rails.application.routes.draw do
  get 'tabs/index'

  resources :reviews do
    get 'finish', on: :collection
  end
end
