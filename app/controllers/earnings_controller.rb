class EarningsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def create
    @earning = Earning.new(earning_params)
    @earning.save
    redirect_to edit_movie_path(@earning.movie), :flash => { :anchor => params['anchor'] }
  end

  private
    def earning_params
      params.require(:earning).permit(:movie_id, :domestic, :foreign, :date)
    end
end
