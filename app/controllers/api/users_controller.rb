class Api::UsersController < ApiController
  include ResourceApi

  respond_to :json

  private

  def resource_class
    User
  end

  def resource_params
    params.require(:user).permit(:email, :password)
  end
end
