Rails.application.routes.draw do

  get '/' => 'home#index'

  get '/post/new' => 'post#new'
  post '/post' => 'post#create'

  get '/post/:post_id/edit' => 'post#edit'
  post '/post/:post_id' => 'post#update'

  get '/post/:post_id/delete' => 'post#delete'


  get '/user/join' => 'user#join'
  post '/user' => 'user#create'

  get '/user/login' => 'user#login'
  post '/user/login' => 'user#find'

  get '/user/logout' => 'user#logout'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
