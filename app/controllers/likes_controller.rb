class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:create, :udpate, :destroy]
  before_action :set_like, only: [:update, :destroy]
    
  def create
    @like = Like.new(like_params)
    @like.user = current_user
    @like.movie = @movie
    
    if @like.save
      @movie.update_averages
      @movie.save
    end

    redirect_to movie_path(@movie)
  end
  
  def update
    if @like.update(like_params)
      @like.movie.update_averages
      @like.movie.save
    
      redirect_to movie_path(@like.movie)
    else
      redirect_to movie_path(@like.movie)
    end
  end
  
  def destroy
    @like.destroy
    @like.movie.update_averages
    @like.movie.save
    
    redirect_to movie_path(@like.movie)
  end
  
  private
  
    def set_movie
      @movie = Movie.friendly.find(params[:movie_id])
    end
    
    def set_like
      @like = Like.find(params[:id])
    end
    
    def like_params
      params.require(:like).permit(:love, :like, :hate)
    end
end
