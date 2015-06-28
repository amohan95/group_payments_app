class SessionsController < ApplicationController

  def login
    response.should render_template(:file => "#{Rails.root}/public/index.html")
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
