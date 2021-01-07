class SessionsController < Devise::SessionsController
  def create
    user_params = params[:user]
    user = User.find_by(email: user_params[:email])
    if user && user.discarded?
      redirect_to root_path, notice: '탈퇴한 회원입니다'
      return
    end
    super
  end
end
