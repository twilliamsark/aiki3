module SessionsHelper
  def sign_in(user, timeout_minutes=30)
    timeout = timeout_minutes.minutes.from_now
    remember_token = UserRememberToken.sign_in(user, ip: request.ip, expires_at: timeout)

    cookies[:remember_token] = {
      value: remember_token,
      expires: timeout
    }

    user.sign_in(remember_token: remember_token, ip: request.remote_ip)
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    UserRememberToken.logout(cookies[:remember_token])
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def admin_signed_in?
    !current_user.nil? && current_user.admin?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    return @current_user if @current_user
    @current_user = nil
    AppLogging.say('Using remember_token cookie to find current user') do
      if cookies[:remember_token].present?
        @current_user = UserRememberToken.find_user(cookies[:remember_token])
        AppLogging.say("#{@current_user.nil? ? 'Did not find user' : 'Found user ' + @current_user.id.to_s}", 1)
      else
        AppLogging.say('Could not find unexpired remember_token cookie', 1)
      end
    end
    @current_user
  end

  def current_user?(user)
    user == current_user
  end

  def demo_user?
    current_user.demo?
  end

  def signed_in_user
    if Rails.env.production? || (!Rails.env.production? && DEVELOPMENT_REQUIRE_LOGIN)
      AppLogging.say("Require signed in user for #{request.url}")
      signin_check
    elsif !signed_in?
      user = User.with_role(:superuser).first
      if user
        sign_in(user, 3000)
      else
        signin_check
      end
    end
  end

  def redirect_back_or(default)
    return_to = session[:return_to] || default
    AppLogging.say("Redirect to stored location #{return_to}") if session[:return_to]
    redirect_to(return_to)
    session.delete(:return_to)
  end

  def store_location
    if request.get?
      AppLogging.say("Store location for future redirect #{request.url}")
      session[:return_to] = request.url
    end
  end

  def signin_check
    unless signed_in?
      respond_to do |format|
        format.html {
          store_location
          redirect_to signin_url
        }
        format.js {
          render 'sessions/redirect_to_login', layout: false
        }
      end
    end
  end
end
