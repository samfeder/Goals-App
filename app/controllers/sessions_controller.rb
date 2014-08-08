class SessionsController < ApplicationController

  before_filter :ensure_signed_out, except: :destroy

  def new
    @user = User.new
  end

  def create
    user = User.find_by_credentials(
                          params[:user][:username],
                          params[:user][:password]
                        )
    if user
      sign_in(user)
      redirect_to user_goals_url(user)
    else
      flash.now[:errors] = ["Invalid username/password combo"]
      @user = User.new(username: params[:user][:username])
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end
end
