class PeopleController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all
    @people = @people.alphabetical
    @people = @people.paginate(:page => params[:page], :per_page => 50)    
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      respond_to do |format|
        format.html { redirect_to person_path(@person) }
        format.js {
          flash[:notice] = "New person was added."
					render :partial => "remote_content/new_person_success.js.erb"
					flash.discard
        }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js {
          flash[:notice] = @person.errors.full_messages.to_sentence
					render :partial => "remote_content/new_person_errors.js.erb"
					flash.discard
        }
      end
    end
  end

  def update
    if @person.update(person_params)
      redirect_to person_path(@person)
    else
      render action: 'edit'
    end
  end

  def destroy
    @person.destroy
    redirect_to person_path(@person)
  end
  
  private
    def set_person
      @person = Person.friendly.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:first_name, :last_name, :display_name, :born, :died, :biography, :promo, :twitter)
    end
end
