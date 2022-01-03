Rails.application.routes.draw do
  
  get 'get_exchange_rates/getRate'
  get 'books/search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
