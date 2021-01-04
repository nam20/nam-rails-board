Rails.application.routes.draw do


  get '/' => 'home#index'

  get '/join' => 'join#join'
  post '/join' => 'join#create'



  get '/session/login' => 'session#login'
  post '/session/login' => 'session#find'

  get '/session/logout' => 'session#logout'



  post '/follow/:id' => 'follow#follow'
  get '/follow/:id' => 'follow#follow'

  post '/unfollow/:id' => 'follow#unfollow'
  get '/unfollow/:id' => 'follow#unfollow'



  get '/post/new' => 'post#new'
  post '/post' => 'post#create'

  get '/post/:id' => 'post#show'

  get '/post/:id/edit' => 'post#edit'
  post '/post/:id' => 'post#update'

  get '/post/:id/delete' => 'post#delete'   # link_to (임시)
  delete '/post/:id/delete' => 'post#delete'
  delete '/post/:id' => 'post#delete'



  post '/like/:id' => 'like#like'
  post '/unlike/:id' => 'like#unlike'

  get '/like/:id' => 'like#like'  # link_to (임시)
  get '/unlike/:id' => 'like#unlike' # link_to (임시)




  post '/comment/:post_id' => 'comment#create'
  post '/comment/:post_id/re/:comment_id' => 'comment#create'

  delete '/comment/:id' => 'comment#delete'

  get '/comment/:id' => 'comment#delete'  # link_to (임시)


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
