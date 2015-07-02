class CrewsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def create
    @crew = Crew.new(crew_params)
    if @crew.save
      redirect_to edit_movie_path(@crew.movie)
    else
      redirect_to edit_movie_path(@crew.movie)
    end
  end

  private
    def crew_params
      params.require(:crew).permit(:person_id, :movie_id, :role, :featured)
    end
end
