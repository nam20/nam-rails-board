class RegistrationsController < Devise::RegistrationsController
  def destroy
    current_user.discard
    sign_out(resource_name)
    redirect_to root_path, notice: 'Signed out successfully.'
  end
end
