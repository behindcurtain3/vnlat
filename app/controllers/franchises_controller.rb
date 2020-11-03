class FranchisesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_franchise, only: [:show, :edit, :update, :destroy]

  def index
    @franchises = Franchise.all    
  end

  def show    
  end

  def new
    @franchise = Franchise.new
  end

  def edit
  end

  def create
    @franchise = Franchise.new(franchise_params)
    @franchise.save
    redirect_to franchise_path(@franchise)
  end

  def update
    @franchise.update(franchise_params)
    redirect_to franchise_path(@franchise)
  end

  def destroy
    @franchise.destroy
    redirect_to franchises_path
  end

  private
    def set_franchise
      @franchise = Franchise.friendly.find(params[:id])
    end

    def franchise_params
      params.require(:franchise).permit(:name)
    end
end
