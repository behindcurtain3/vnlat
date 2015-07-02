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
#  name               :string(255)
#

class Person < ActiveRecord::Base
  extend FriendlyId
  
  acts_as_api
  include ApiV1::Person
  friendly_id :slug_candidates, use: :slugged
  
  has_many :characters
  has_many :movies, through: :characters
  has_many :directed, class_name: 'Movie', foreign_key: 'director_id'
  
  before_save :update_name
  
  has_attached_file :promo, styles: {
      thumb: '85x125>',
      medium: '450x450>',
      large: '669x1000#'
    },
    s3_protocol: 'https'
  
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :promo, :content_type => /\Aimage\/.*\Z/
  
  validates :first_name,
    presence: true,
    :if => 'display_name.blank?'
    
  validates :last_name,
    presence: true,
    :if => 'display_name.blank?'
  
  def slug_candidates
    [
      [:first_name, :last_name],
      [:first_name, :last_name, :born]
    ]
  end
  
  def update_name
    if self.display_name.blank?
      self.name = self.first_name + " " + self.last_name
    else
      self.name = self.display_name
    end
  end
  
  def age
    return nil if self.born.nil?
    now = DateTime.now
    age = now.year - self.born.year
    age -= 1 if(now.yday < self.born.yday)
    age
  end
end
