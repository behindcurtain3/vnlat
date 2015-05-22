# == Schema Information
#
# Table name: movies
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  year                :integer
#  avg_v               :integer
#  avg_n               :integer
#  avg_l               :integer
#  avg_at              :integer
#  created_at          :datetime
#  updated_at          :datetime
#  slug                :string(255)
#  poster_file_name    :string(255)
#  poster_content_type :string(255)
#  poster_file_size    :integer
#  poster_updated_at   :datetime
#  summary             :text
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
  
  test "summary should be present" do
    @movie.summary = ''
    assert_not @movie.valid?
  end
  
end
