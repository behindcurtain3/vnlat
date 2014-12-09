# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  v          :integer
#  n          :integer
#  l          :integer
#  at         :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  
  def setup
    @rating = ratings(:one)
  end

  test "should be valid" do
    assert @rating.valid?
  end
  
  test "user should be present" do
    @rating.user_id = nil
    assert_not @rating.valid?
  end
  
  test "movie should be present" do
    @rating.movie_id = nil
    assert_not @rating.valid?
  end
  
  test "v should be present" do
    @rating.v = nil
    assert_not @rating.valid?
  end
  
  test "v should be at least 0" do
    @rating.v = -1
    assert_not @rating.valid?
  end
  
  test "v should be at most 5" do
    @rating.v = 6
    assert_not @rating.valid?
  end
  
  test "n should be present" do
    @rating.n = nil
    assert_not @rating.valid?
  end
  
  test "n should be at least 0" do
    @rating.n = -1
    assert_not @rating.valid?
  end
  
  test "n should be at most 5" do
    @rating.n = 6
    assert_not @rating.valid?
  end
  
  test "l should be present" do
    @rating.l = nil
    assert_not @rating.valid?
  end
  
  test "l should be at least 0" do
    @rating.l = -1
    assert_not @rating.valid?
  end
  
  test "l should be at most 5" do
    @rating.l = 6
    assert_not @rating.valid?
  end

  test "at should be present" do
    @rating.at = nil
    assert_not @rating.valid?
  end
  
  test "at should be at least 0" do
    @rating.at = -1
    assert_not @rating.valid?
  end
  
  test "at should be at most 5" do
    @rating.at = 6
    assert_not @rating.valid?
  end

end
