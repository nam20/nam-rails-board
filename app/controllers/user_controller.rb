class UserController < ApplicationController

  def delete
    if session[:user_id].nil?
      redirect_to root_path
      return
    end

    user = User.find(session[:user_id])
    user.update(is_deleted: true)

    redirect_to root_path

  end


end
