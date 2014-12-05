# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  year       :integer
#  avg_v      :integer
#  avg_n      :integer
#  avg_l      :integer
#  avg_at     :integer
#  g_v        :integer
#  g_n        :integer
#  g_l        :integer
#  g_at       :integer
#  j_v        :integer
#  j_n        :integer
#  j_l        :integer
#  j_at       :integer
#  g_comments :string(255)
#  j_comments :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def setup
    @movie = movies(:gladiator)
  end
  
  test "should be valid" do
    assert @movie.valid?
  end
  
  test "title should be present" do
    @movie.title = ''
    assert_not @movie.valid?
  end
  
  test "year should be present" do
    @movie.year = nil
    assert_not @movie.valid?
  end
  
  test "year should be at least 1900" do
    @movie.year = 1899
    assert_not @movie.valid?
  end

end
