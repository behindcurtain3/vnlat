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

require 'test_helper'

class TrailerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
