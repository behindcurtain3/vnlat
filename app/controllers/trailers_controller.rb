class TrailersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_trailer, only: [:update, :destroy]

  respond_to :html

  def create
    @trailer = Trailer.new(trailer_params)
    if @trailer.save
      redirect_to edit_movie_path(@trailer.movie)
    else
      redirect_to edit_movie_path(@trailer.movie)
    end
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
    respond_with(@trailer)
  end

  private
    def set_trailer
      @trailer = Trailer.find(params[:id])
    end

    def trailer_params
      params.require(:trailer).permit(:movie_id, :code, :active)
    end
end
