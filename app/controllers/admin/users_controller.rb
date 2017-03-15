class Admin::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with(User.all)
  end

  def create
    @user = User.create(user_params)
    resource_response(@user, :created)
  end

  def update
    @user = resource
    @user.update_attributes(user_params)
    resource_response(@user)
  end

  def destroy
    resource.destroy
    head :no_content
  end

  private

  def resource
    User.find(params[:id])
  end

  def resource_response(record, status = :ok)
    if record.valid?
      render json: record, status: status
    else
      render json: record.errors, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
