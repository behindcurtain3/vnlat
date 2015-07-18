class PagesController < ApplicationController
  def about
  end
  
  def chris
    @contenders = Person.where('slug = ? OR slug = ? OR slug = ? OR slug = ?', 'chris-evans', 'chris-hemsworth', 'chris-pine', 'chris-pratt')
    @contenders = @contenders.order('name ASC')
  end
end
