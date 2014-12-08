class Api::V1::MoviesController < ApplicationController
  before_action :set_movie, only: [:show]

  def index
    @movies = Movie.paginate(:page => params[:page])
    meta_data = { :page => params[:page], :total => Movie.count }

    respond_to do |format|
      format.json { render_for_api :public, :json => @movies, :root => :movies, :meta => meta_data }
      format.xml { render_for_api :public, :xml => @movies, :root => :movies, :meta => meta_data }
    end
  end

  def show
    respond_to do |format|
      format.json { render_for_api :detailed, :json => @movie }
      format.xml { render_for_api :detailed, :xml => @movie }
    end
  end

  private
    def set_movie
      @movie = Movie.friendly.find(params[:id])
    end
end
