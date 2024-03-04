#create route,controller, action and view for new
# create route,controller, action and view for score

Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end
