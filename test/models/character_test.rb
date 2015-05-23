# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  movie_id   :integer
#  name       :string(255)
#  importance :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
