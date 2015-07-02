class QuotesController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      redirect_to edit_movie_path(@quote.movie)
    else
      redirect_to edit_movie_path(@quote.movie)
    end
  end

  private
    def quote_params
      params.require(:quote).permit(:movie_id, :character_id, :text)
    end
end
