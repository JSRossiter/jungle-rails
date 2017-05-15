class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      flash.now[:error] = 'Incorrect email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    render :new
  end
end
