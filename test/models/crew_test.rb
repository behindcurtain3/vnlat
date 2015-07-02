# == Schema Information
#
# Table name: crews
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  person_id  :integer
#  role       :string(255)
#  importance :integer          default(0)
#  featured   :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CrewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
