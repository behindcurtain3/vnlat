class MoviesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :boxoffice]
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :boxoffice, :trailers, :reviews]
  autocomplete :person, :name

  respond_to :html

  def index
    if params[:genre]
      @movies = Movie.tagged_with(params[:genre])
    elsif params[:q]
      @movies = @q.result(distinct: true)
    else
      @movies = Movie.all
    end
    
    @movies = @movies.paginate(:page => params[:page], :per_page => 50)
    
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
    @new = Character.new
    @trailer = Trailer.new
    @review = Review.new
    @quote = Quote.new
    @crew = Crew.new
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
      redirect_to edit_movie_path(@movie)
    else
      render action: 'edit'
    end
  end

  def destroy
    @movie.destroy
    respond_with(@movie)
  end
  
  def boxoffice
    respond_with(@movie)
  end
  
  def trailers
    respond_with(@movie)
  end
  
  def reviews
    respond_with(@movie)
  end

  private
    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :year, :poster, :director_id, :summary,
        :runtime, :mpaa, :released,
        :tag_list, :boxoffice_us, :boxoffice_foreign, :boxoffice_worldwide, 
        :j_v, :j_n, :j_l, :j_at, :g_v, :g_n, :g_l, :g_at,
        characters_attributes: [:id, :name, :person_id, :movie_id, :importance, :_destroy],
        crews_attributes: [:id, :person_id, :movie_id, :role, :importance, :featured, :_destroy],
        trailers_attributes: [:id, :movie_id, :code, :active, :_destroy],
        reviews_attributes: [:id, :movie_id, :code, :active, :_destroy],
        quotes_attributes: [:id, :movie_id, :character_id, :text, :_destroy])
    end
end
