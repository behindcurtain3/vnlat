class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user
  
  def show
    @ratings = @user.ratings
    @ratings = @ratings.paginate(:page => params[:page], :per_page => 10)
  end
  
  private
  
    def set_user
      if signed_in? && params[:id] == current_user.id
			  @user = current_user
		  else
			  @user = User.find(params[:id])
		  end 
    end
end
