Rails.application.routes.draw do
  root "page#index"
  get "/products", to: "page#products"
  post "/preference", to: "preference#setting"
end
