class AppearancesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @appearance = Appearance.new(appearance_params)
    @appearance.save
    redirect_to edit_movie_path(@appearance.movie), :flash => { :anchor => params['anchor'] }
  end

  private
    def appearance_params
      params.require(:appearance).permit(:movie_id, :person_id, :character_id, :name, :importance, :uncredited)
    end
end
