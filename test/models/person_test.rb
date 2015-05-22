# == Schema Information
#
# Table name: people
#
#  id                 :integer          not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  display_name       :string(255)
#  born               :date
#  died               :date
#  twitter            :string(255)
#  biography          :text
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string(255)
#  promo_file_name    :string(255)
#  promo_content_type :string(255)
#  promo_file_size    :integer
#  promo_updated_at   :datetime
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:example)
  end
  
  test "should be valid" do
    assert @person.valid?
  end
end
