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
  
  validates :name,
    presence: true
  
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [
      :name
    ]
  end
  
  scope :alphabetical, -> { order(name: :asc) }
end
