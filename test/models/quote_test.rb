# == Schema Information
#
# Table name: quotes
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  movie_id      :integer
#  appearance_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
