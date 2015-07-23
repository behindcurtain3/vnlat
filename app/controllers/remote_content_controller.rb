class RemoteContentController < ApplicationController
  def remote_new_person
    @person = Person.new
  end
  
  def remote_new_character
    @character = Character.new
  end
end