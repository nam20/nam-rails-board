Rails.application.routes.draw do

  get '/' => 'home#index'

  get '/post/new' => 'post#new'
  post '/post' => 'post#create'

  get '/post/:post_id' => 'post#post'

  get '/post/:post_id/edit' => 'post#edit'
  post '/post/:post_id' => 'post#update'

  get '/post/:post_id/delete' => 'post#delete'
  delete '/post/:post_id' => 'post#delete'

  get '/user/join' => 'user#join'
  post '/user' => 'user#create'

  get '/user/login' => 'user#login'
  post '/user/login' => 'user#find'

  get '/user/logout' => 'user#logout'

  post '/post/:post_id/like/:user_id' => 'post#like'
  post '/post/:post_id/unlike/:user_id' => 'post#unlike'

  post '/comment/:post_id' => 'comment#create'
  post '/comment/:post_id/re/:comment_id' => 'comment#create'

  delete '/comment/:comment_id' => 'comment#delete'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
