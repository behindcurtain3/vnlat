class PagesController < ApplicationController
  def about
  end
  
  # the-real-chris
  def chris
    @contenders = Person.where('slug = ? OR slug = ? OR slug = ? OR slug = ?', 'chris-evans', 'chris-hemsworth', 'chris-pine', 'chris-pratt')
    @contenders = @contenders.order('name ASC')
  end
  
  # coming soon
  def soon
    @movies = Movie.where('released > ?', Date.today).by_release_asc
  end
  
  #top actors
  def top_actors
    @domestic = Person.joins(:movies)
      .select('people.*, sum(boxoffice_us) as "sum_us"')
      .where.not({ movies: { boxoffice_us: nil } })
      .group('people.id')
      .order('sum_us desc')
      .limit(50)
    @worldwide = Person.joins(:movies)
      .select('people.*, sum(boxoffice_worldwide) as "sum_us"')
      .where.not({ movies: { boxoffice_worldwide: nil } })
      .group('people.id')
      .order('sum_us desc')
      .limit(50)
  end
  
  # top movies
  def top_movies
    @domestic = Movie.order(:boxoffice_us => :desc).where.not(:boxoffice_us => nil).limit(50)
    @worldwide = Movie.order(:boxoffice_worldwide => :desc).where.not(:boxoffice_worldwide => nil).limit(50)
  end
end
