Rails.application.routes.draw do


  get '/' => 'home#index'

  get '/user/join' => 'user#join'
  post '/user' => 'user#create'

  get '/user/login' => 'user#login'
  post '/user/login' => 'user#find'

  get '/user/logout' => 'user#logout'

  post '/user/:user_id/follow' => 'user#follow'
  get '/user/:user_id/follow' => 'user#follow'

  post '/user/:user_id/unfollow' => 'user#unfollow'
  get '/user/:user_id/unfollow' => 'user#unfollow'

  get '/post/new' => 'post#new'
  post '/post' => 'post#create'

  get '/post/:post_id' => 'post#show'

  get '/post/:post_id/edit' => 'post#edit'
  post '/post/:post_id' => 'post#update'

  get '/post/:post_id/delete' => 'post#delete'   # link_to (임시)
  delete '/post/:post_id' => 'post#delete'

  post '/post/:post_id/like' => 'post#like'
  post '/post/:post_id/unlike' => 'post#unlike'

  get '/post/:post_id/like' => 'post#like'  # link_to (임시)
  get '/post/:post_id/unlike' => 'post#unlike' # link_to (임시)




  post '/comment/:post_id' => 'comment#create'
  post '/comment/:post_id/re/:comment_id' => 'comment#create'

  delete '/comment/:comment_id' => 'comment#delete'

  get '/comment/:comment_id' => 'comment#delete'  # link_to (임시)


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
