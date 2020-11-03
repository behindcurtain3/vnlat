class QuotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @quote = Quote.new(quote_params)
    @quote.save
    redirect_to edit_movie_path(@quote.movie), :flash => { :anchor => params['anchor'] }
  end

  private
    def quote_params
      params.require(:quote).permit(:movie_id, :appearance_id, :text)
    end
end
