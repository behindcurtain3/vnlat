# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#  alias      :string(255)
#

class Character < ActiveRecord::Base
  extend FriendlyId
  
  has_many :appearances
  has_many :movies, through: :appearances, source: :movie
  has_many :actors, through: :appearances, source: :person

  validates :name,
    presence: true
    
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [
      [:name]
    ]
  end
    
end
