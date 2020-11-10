# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  code       :string(255)
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Review < ApplicationRecord
  belongs_to :movie
  has_paper_trail
end
