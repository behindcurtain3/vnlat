class CharactersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    respond_with(@character)
  end

  def new
    @character = Character.new
    respond_with(@character)
  end

  def edit
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to edit_movie_path(@character.movie), :flash => { :anchor => params['anchor'] }
    else
      render action: 'new'
    end
  end

  def update
    if @character.update(character_params)
      redirect_to edit_movie_path(@character.movie)
    else
      render action: 'edit'
    end
  end

  def destroy
    @character.destroy
    respond_with(@character)
  end

  private
    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :person_id, :movie_id, :importance)
    end
end
