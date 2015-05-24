class MoviesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:tag]
      @movies = Movie.tagged_with(params[:tag])
    elsif params[:q]
      @movies = @q.result(distinct: true)
    else
      @movies = Movie.all
    end
    
    @movies = @movies.paginate(:page => params[:page], :per_page => 10)
    
    respond_with(@movies)
  end

  def show
    if user_signed_in? and current_user.rated?(@movie)
      @rating = current_user.ratings.where(:movie_id => @movie.id).first
    end
    respond_with(@movie)
  end

  def new
    @movie = Movie.new
    respond_with(@movie)
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
      
      client.update(@movie.title << " was just added, check out the rating here: " << movie_url(@movie))
      
      respond_with(@movie)
    else
      render action: 'new'
    end
  end

  def update
    if @movie.update(movie_params)
      respond_with(@movie)
    else
      render action: 'edit'
    end
  end

  def destroy
    @movie.destroy
    respond_with(@movie)
  end

  private
    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :year, :poster, :summary, :tag_list, :boxoffice_us, :boxoffice_foreign, :boxoffice_worldwide, :j_v, :j_n, :j_l, :j_at, :g_v, :g_n, :g_l, :g_at)
    end
end
