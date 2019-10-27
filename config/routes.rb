Rails.application.routes.draw do
  get "/", to: "pages#index"
  post "/", to: "pages#index"
end
