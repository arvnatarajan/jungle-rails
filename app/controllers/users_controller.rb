class UsersController < ApplicationController

  def new
  end

  def index
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/users/new',
      notice: 'Error........'
    end
  end

  private

  def user_params
    new_params = params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
      )
    new_params[:email] = params[:user][:email].squish.downcase

    return new_params
  end
end
