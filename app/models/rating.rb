# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  v          :integer
#  n          :integer
#  l          :integer
#  at         :integer
#  created_at :datetime
#  updated_at :datetime
#

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie
    
  validates :user_id,
    presence: true

  validates :movie_id,
    presence: true
    
  validates :v,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    
  validates :n,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    
  validates :l,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    
  validates :at,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    
end
