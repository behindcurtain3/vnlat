class CharactersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @characters = Character.all
  end

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
      respond_to do |format|
        format.html {
          respond_with(@character)    
        }
        format.js {
          flash[:notice] = "New character was added."
					render :partial => "remote_content/new_character_success.js.erb"
					flash.discard
        }
      end
    else
      respond_to do |format|
        format.html {
          render action: 'new'    
        }
        format.js {
          flash[:notice] = @character.errors.full_messages.to_sentence
					render :partial => "remote_content/new_character_errors.js.erb"
					flash.discard
        }
      end
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
      @character = Character.friendly.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :alias)
    end
end
