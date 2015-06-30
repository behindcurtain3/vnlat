# == Schema Information
#
# Table name: trailers
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  code       :string(255)
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Trailer < ActiveRecord::Base
  belongs_to :movie
  
  validates :movie,
    presence: true
    
  validates :code,
    presence: true
end
