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

require 'test_helper'

class FranchiseMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
