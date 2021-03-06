class EarningsController < ApplicationController
  before_action :authenticate_user!

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
