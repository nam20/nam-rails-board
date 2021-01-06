Rails.application.routes.draw do

  resources :posts

  root 'posts#index'

  get '/join' => 'join#join'
  post '/join' => 'join#create'


  get '/login' => 'session#login'
  post '/login' => 'session#find'
  delete '/logout' => 'session#logout'


  post '/follow/:id' => 'follow#follow'
  delete '/follow/:id' => 'follow#unfollow'


  post '/posts/:id/like' => 'like#like'
  delete '/posts/:id/like' => 'like#unlike'


  post '/posts/:post_id/comment' => 'comment#create'
  delete '/posts/:post_id/comment/:comment_id' => 'comment#delete'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
