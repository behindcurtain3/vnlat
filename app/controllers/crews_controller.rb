class CrewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @crew = Crew.new(crew_params)
    @crew.save
    redirect_to edit_movie_path(@crew.movie), :flash => { :anchor => params['anchor'] }
  end

  private
    def crew_params
      params.require(:crew).permit(:person_id, :movie_id, :role, :featured)
    end
end
