# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  love       :boolean
#  like       :boolean
#  hate       :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
