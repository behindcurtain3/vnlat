class ReviewsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to edit_movie_path(@review.movie)
    else
      redirect_to edit_movie_path(@review.movie)
    end
  end

  private
    def review_params
      params.require(:review).permit(:movie_id, :code, :active)
    end
end
