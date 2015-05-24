# == Schema Information
#
# Table name: quotes
#
#  id           :integer          not null, primary key
#  text         :string(255)
#  movie_id     :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Quote < ActiveRecord::Base
  belongs_to :movie
  belongs_to :character
  
  validates :text,
    presence: true
    
  validates :movie,
    presence: true
    
  validates :character,
    presence: true
end
