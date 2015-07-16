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

require 'test_helper'

class EarningTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
