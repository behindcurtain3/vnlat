# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  movie_id   :integer
#  name       :string(255)
#  importance :integer
#  created_at :datetime
#  updated_at :datetime
#

class Character < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
  has_many :quotes
  
  scope :ranked, -> { includes(:person).order('importance ASC')
    .order('people.last_name ASC')
    .order('people.first_name ASC')
    .order('people.name ASC') }
  scope :alphabetical, -> { order('name') }
  scope :by_year, -> { includes(:movie).order('movies.year DESC') }
  
  validates :person,
    presence: true
    
  validates :movie,
    presence: true
    
  validates :name,
    presence: true
    
  validates :importance,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    
end
