# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_signed_out_user

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params[:email].downcase)

    if @user.valid_password?(params[:password])
      sign_in(@user)
      render json: { status: 'Success', message: 'signed in', data: UserSerializer.new(@user) }, status: :ok
    else
      render json: { status: 'failed', message: 'unauthorized' }, status: 401
    end
  end

  # DELETE /resource/sign_out
  def destroy
    @user = current_user
    if @user
      sign_out(@user)
      render json: { status: 'Success', message: 'signed out', data: UserSerializer.new(@user) }, status: 200
    else
      render json: { status: 'Failed', message: 'There is no user to sign out' }, status: :unauthorized
    end
  end

  # protected
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
