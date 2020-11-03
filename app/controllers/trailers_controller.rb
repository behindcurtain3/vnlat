class TrailersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_trailer, only: [:update, :destroy]

  def create
    @trailer = Trailer.new(trailer_params)
    @trailer.save
    redirect_to edit_movie_path(@trailer.movie), :flash => { :anchor => params['anchor'] }
  end

  def update
    if @trailer.update(trailer_params)
      redirect_to edit_movie_path(@trailer.movie)
    else
      redirect_to edit_movie_path(@trailer.movie)
    end
  end

  def destroy
    @trailer.destroy
    redirect_to movie_path(@trailer.movie)
  end

  private
    def set_trailer
      @trailer = Trailer.find(params[:id])
    end

    def trailer_params
      params.require(:trailer).permit(:movie_id, :code, :active)
    end
end
