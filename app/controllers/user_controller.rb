class UserController < ApplicationController

  def delete
    unless session[:user_id]
      redirect_to '/'
      return
    end

    user = User.find(session[:user_id])
    user.update(is_deleted: true)

    redirect_to '/'

  end


end
