# == Schema Information
#
# Table name: crews
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  person_id  :integer
#  role       :string(255)
#  importance :integer          default(0)
#  featured   :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Crew < ApplicationRecord
  belongs_to :movie
  belongs_to :person
  
  scope :ranked, -> { includes(:person).order('importance ASC')
    .order('people.last_name ASC')
    .order('people.first_name ASC')
    .order('people.name ASC') }
  
  validates :person,
    presence: true
    
  validates :movie,
    presence: true
    
  validates :role,
    presence: true
    
  validates :importance,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
