# == Schema Information
#
# Table name: appearances
#
#  id           :integer          not null, primary key
#  movie_id     :integer
#  person_id    :integer
#  character_id :integer
#  name         :string(255)
#  importance   :integer
#  uncredited   :boolean          default(FALSE), not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Appearance < ApplicationRecord
  belongs_to :movie
  belongs_to :person
  belongs_to :character, optional: true
  has_many :quotes
  
  # validations
  validates :movie,
    presence: true
    
  validates :person,
    presence: true
    
  validates :importance,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    
  # scopes
  scope :ranked, -> { includes(:person).order('importance ASC')
    .order('people.last_name ASC')
    .order('people.first_name ASC')
    .order('people.name ASC') }
    
  scope :by_year, -> { includes(:movie).order('movies.released DESC') }

  scope :distinct_by_count, -> { select("appearances.person_id").group("appearances.person_id").order("COUNT(appearances.person_id) DESC, SUM(appearances.importance) ASC") }
  
  # methods
  def display
    return self.character.name unless self.character.nil?
    return self.name
  end
end
