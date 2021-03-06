class SessionsController < ApplicationController
  before_action :redirect_if_logged_out, only: [:destroy]
  # before_action :redirect_if_logged_in, except: [:destroy]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      login!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ["Username and password combination doesn't exist"]
      @user = User.new(session_params)
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
