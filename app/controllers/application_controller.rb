class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_search
  
  def set_search
    @q = Movie.search(params[:q])
  end
  
  def info_for_paper_trail
    { :author_username => current_user.blank? ? '' : current_user.email }
  end
end
