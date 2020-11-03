# == Schema Information
#
# Table name: earnings
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  domestic   :integer          default(0)
#  foreign    :integer          default(0)
#  worldwide  :integer          default(0)
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

class Earning < ApplicationRecord
  before_save :sum_earnings
  belongs_to :movie
  
  validates :date,
    presence: true
    
  validates :movie,
    presence: true
    
  def sum_earnings
    self.worldwide = self.domestic + self.foreign
  end
end
