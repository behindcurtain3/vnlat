class ReviewsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to edit_movie_path(@review.movie), :flash => { :anchor => params['anchor'] }
  end

  private
    def review_params
      params.require(:review).permit(:movie_id, :code, :active)
    end
end
