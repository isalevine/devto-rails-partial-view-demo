Rails.application.routes.draw do
  get "/mtg", to: "pages#mtg"
  post "/mtg", to: "pages#mtg"

  get "/swccg", to: "pages#swccg"
  post "/swccg", to: "pages#swccg"
end
