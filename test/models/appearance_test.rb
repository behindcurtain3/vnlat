# == Schema Information
#
# Table name: appearances
#
#  id           :integer          not null, primary key
#  movie_id     :integer
#  person_id    :integer
#  character_id :integer
#  name         :string(255)
#  importance   :integer
#  uncredited   :boolean          default(FALSE), not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class AppearanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
