# app/controllers/users/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @user = User.new(password: params[:password],
                     password_confirmation: params[:password_confirmation], email: params[:email])
                     
    if @user.save!
      render json: { status: 'Success', message: 'created users', data: UserSerializer.new(@user) }, status: :ok
    else
      render json: {
        status: 422,
        message: 'Registration failed'
      }, status: 422
    end
  end

  # ... (other actions)

  protected
  # ...

  # The path used after sign up.
  # The path used after sign up for inactive accounts.
end
