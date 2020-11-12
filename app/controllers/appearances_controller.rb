class AppearancesController < ApplicationController
  before_action :authenticate_user!

  def create    
    @appearance = Appearance.new(appearance_params)
    if @appearance.save
      UpdatePersonBoxofficeJob.perform_later @appearance.person.id
      redirect_to edit_movie_path(@appearance.movie), :flash => { :anchor => params['anchor'] }
    else
      redirect_to edit_movie_path(@appearance.movie), :flash => { :anchor => params['anchor'], :notice => "Unable to save the appearance" }
    end
  end

  private
    def appearance_params
      params.require(:appearance).permit(:movie_id, :person_id, :character_id, :name, :importance, :uncredited)
    end
end
