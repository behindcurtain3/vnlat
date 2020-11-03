class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:new, :create, :edit, :udpate, :destroy]
  before_action :set_rating, only: [:edit, :update, :destroy]
  
  def new
    @rating = Rating.new    
  end
  
  def edit
    @movie = @rating.movie
  end
  
  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @rating.movie = @movie
    
    if @rating.save
      @movie.update_averages
      @movie.save
      redirect_to movie_path(@movie)
    else
      render action: 'new'
    end
  end
  
  def update
    if @rating.update(rating_params)
      @rating.movie.update_averages
      @rating.movie.save
    
      redirect_to movie_path(@rating.movie)
    else
      @movie = @rating.movie
      render action: 'edit'
    end
  end
  
  def destroy
    @rating.destroy
    @rating.movie.update_averages
    @rating.movie.save
    
    redirect_to movie_path(@rating.movie)
  end
  
  private
  
    def set_movie
      @movie = Movie.friendly.find(params[:movie_id])
    end
    
    def set_rating
      @rating = Rating.find(params[:id])
    end
    
    def rating_params
      params.require(:rating).permit(:v, :n, :l, :at)
    end
end
