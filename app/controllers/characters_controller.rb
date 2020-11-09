class CharactersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  def index
    @characters = Character.all
  end

  def show    
  end

  def new
    @character = Character.new    
  end

  def edit
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      respond_to do |format|
        format.html
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
      redirect_to character_path(@character)
    else
      render action: 'edit'
    end
  end

  def destroy
    @character.destroy
    redirect_to characters_path
  end

  private
    def set_character
      @character = Character.friendly.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :alias)
    end
end
