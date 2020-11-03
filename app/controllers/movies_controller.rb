class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :boxoffice, :trailers, :reviews, :quotes]
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :boxoffice, :trailers, :reviews, :quotes]
  before_action :set_paper_trail_whodunnit
  autocomplete :person, :name
  autocomplete :character, :name
  
  has_scope :year
  has_scope :year_greater
  has_scope :year_greater_equal
  has_scope :year_less
  has_scope :year_less_equal
  has_scope :starts_with
  has_scope :released_after
  has_scope :released_before
  has_scope :genre
  
  def index
    if params[:q]
      @movies = @q.result(distinct: true)
    else
      @movies = Movie.all
    end
    
    @movies = apply_scopes(@movies).all
    @movies = @movies.paginate(:page => params[:page], :per_page => 50)    
  end

  def show
    if user_signed_in? and current_user.rated?(@movie)
      @rating = current_user.ratings.where(:movie_id => @movie.id).first
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
    @appearance = Appearance.new
    @trailer = Trailer.new
    @review = Review.new
    @quote = Quote.new
    @crew = Crew.new
    @franchise_member = FranchiseMember.new
    @earning = Earning.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      
      #client = Twitter::REST::Client.new do |config|
      #  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      #  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      #  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      #  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      #end
      
      #client.update(@movie.title << " was just added, check out the rating here: " << movie_url(@movie))
      
      redirect_to movie_path(@movie)
    else
      render action: 'new'
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to edit_movie_path(@movie), :flash => { :anchor => params['anchor'] }
    else
      render action: 'edit'
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end
  
  def boxoffice    
  end
  
  def trailers    
  end
  
  def reviews    
  end
  
  def quotes    
  end

  private
    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :year, :poster, :director_id, :summary,
        :runtime, :mpaa, :released, :spotify,
        :tag_list, :boxoffice_us, :boxoffice_foreign, 
        :j_v, :j_n, :j_l, :j_at, :g_v, :g_n, :g_l, :g_at,
        appearances_attributes: [:id, :name, :person_id, :movie_id, :character_id, :importance, :uncredited, :_destroy],
        crews_attributes: [:id, :person_id, :movie_id, :role, :importance, :featured, :_destroy],
        trailers_attributes: [:id, :movie_id, :code, :active, :_destroy],
        reviews_attributes: [:id, :movie_id, :code, :active, :_destroy],
        quotes_attributes: [:id, :movie_id, :character_id, :text, :_destroy],
        franchise_members_attributes: [:id, :movie_id, :franchise_id, :_destroy],
        earnings_attributes: [:id, :movie_id, :domestic, :foreign, :date, :_destroy])
    end
end
