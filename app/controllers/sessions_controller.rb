class SessionsController < ApplicationController
  def new
    @no_menu = true
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if authenticate(user)
      sign_in(user, user.admin? ? 90 : 60)
      redirect_back_or root_path
    else
      flash.now[:error] = 'Login invalid'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  private

  def authenticate(user)
    authentic = user && user.authenticate(params[:session][:password])
    authentic = false if user && user.demo? && !user.demo_user_expires_on.nil? && user.demo_user_expires_on.at_end_of_day.past?
    return authentic
  end
end
