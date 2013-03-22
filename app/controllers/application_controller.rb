class ApplicationController < ActionController::Base

  include Mobylette::RespondToMobileRequests
  protect_from_forgery
  before_filter :authorize
  before_filter :check_user

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def check_user
    @user = User.find_by_id(session[:user_id])
  end

end
