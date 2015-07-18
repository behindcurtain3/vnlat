class FranchiseMembersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def create
    @franchise_member = FranchiseMember.new(franchise_member_params)
    @franchise_member.save
    redirect_to edit_movie_path(@franchise_member.movie), :flash => { :anchor => params['anchor'] }
  end

  private
    def franchise_member_params
      params.require(:franchise_member).permit(:movie_id, :franchise_id)
    end
end
