class RootController < ApplicationController
  protect_from_forgery
  skip_before_filter :authorize

  def index()
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
