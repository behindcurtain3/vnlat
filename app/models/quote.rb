# == Schema Information
#
# Table name: quotes
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  movie_id      :integer
#  appearance_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Quote < ApplicationRecord
  belongs_to :movie
  belongs_to :appearance
  
  validates :text,
    presence: true
    
  validates :movie,
    presence: true
    
  validates :appearance,
    presence: true
end
