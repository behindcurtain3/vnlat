# == Schema Information
#
# Table name: franchises
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class Franchise < ApplicationRecord
  extend FriendlyId
  
  has_many :franchise_members
  has_many :movies, through: :franchise_members, source: :movie
  has_many :appearances, -> { includes(:person) }, through: :movies, source: :appearances
  
  validates :name,
    presence: true
  
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [
      :name
    ]
  end
  
  scope :alphabetical, -> { order(name: :asc) }
  #scope :ordered_stars, -> { left_joins(:stars).order('COUNT("appeareances"."person_id") DESC').distinct }
end
