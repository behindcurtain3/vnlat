class PagesController < ApplicationController
  def about
  end
  
  # the-real-chris
  def chris
    @contenders = Person.where('slug = ? OR slug = ? OR slug = ? OR slug = ?', 'chris-evans', 'chris-hemsworth', 'chris-pine', 'chris-pratt')
    @contenders = @contenders.order('name ASC')
  end
  
  # top movies
  def top
    @domestic = Movie.order(:boxoffice_us => :desc).where.not(:boxoffice_us => nil).limit(50)
    @worldwide = Movie.order(:boxoffice_worldwide => :desc).where.not(:boxoffice_worldwide => nil).limit(50)
  end
end
