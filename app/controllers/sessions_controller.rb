class SessionsController < ApplicationController

  def login
    response.should render_template(:file => "#{Rails.root}/public/index.html")
  end

  def create
    session[:auth_hash] = auth_hash
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
