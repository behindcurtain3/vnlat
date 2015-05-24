class Api::V1::PeopleController < ApplicationController
  before_action :set_person, only: [:show]

  def index
    @people = Person.paginate(:page => params[:page])
    meta_data = { :page => params[:page], :total => Person.count }

    respond_to do |format|
      format.json { render_for_api :public, :json => @people, :root => :people, :meta => meta_data }
      format.xml { render_for_api :public, :xml => @people, :root => :people, :meta => meta_data }
    end
  end

  def show
    respond_to do |format|
      format.json { render_for_api :detailed, :json => @person }
      format.xml { render_for_api :detailed, :xml => @person }
    end
  end

  private
    def set_person
      @person = Person.friendly.find(params[:id])
    end
end
