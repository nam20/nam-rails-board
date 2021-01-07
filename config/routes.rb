Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  resources :posts

  root 'posts#index'

  post '/follow/:id' => 'follows#follow'
  delete '/follow/:id' => 'follows#unfollow'


  post '/posts/:id/like' => 'likes#like'
  delete '/posts/:id/like' => 'likes#unlike'


  post '/posts/:post_id/comment' => 'comments#create'
  delete '/posts/:post_id/comment/:comment_id' => 'comments#delete'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
