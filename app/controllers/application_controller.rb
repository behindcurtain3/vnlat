class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_search
  
  def set_search
    @q = Movie.ransack(params[:q])
  end
  
  def info_for_paper_trail
    return { author_username: current_user.email } unless current_user.blank?
    return { author_username: "Unknown" }    
  end
end
