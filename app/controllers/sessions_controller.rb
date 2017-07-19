class SessionsController < ApplicationController
  before_action :ensure_no_user!, only: [:create, :new]

  def new

  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    logout
  end
end
