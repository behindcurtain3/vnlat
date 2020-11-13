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

  belongs_to :previous, class_name: "Movie", foreign_key: "previous_id", optional: true
  belongs_to :next, class_name: "Movie", foreign_key: "next_id", optional: true
end
