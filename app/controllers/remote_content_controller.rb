class RemoteContentController < ApplicationController
  def remote_new_person
    @person = Person.new
  end
end