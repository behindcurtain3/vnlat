# == Schema Information
#
# Table name: franchise_members
#
#  id           :integer          not null, primary key
#  movie_id     :integer
#  franchise_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class FranchiseMember < ApplicationRecord
  belongs_to :movie
  belongs_to :franchise
end
