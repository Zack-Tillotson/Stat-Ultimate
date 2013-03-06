class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  def index()
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

end
