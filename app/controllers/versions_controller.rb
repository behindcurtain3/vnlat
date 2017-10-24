class VersionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_movie_and_version, only: [:diff, :rollback, :destroy]
  before_action :set_paper_trail_whodunnit

  def diff
  end

  def rollback
    # change the current document to the specified version
    # reify gives you the object of this version
    movie = @version.reify
    movie.save
    redirect_to edit_movie_path(movie)
  end

  private

    def set_movie_and_version
      @movie = Movie.friendly.find(params[:movie_id])
      @version = @movie.versions.find(params[:id])
    end

end