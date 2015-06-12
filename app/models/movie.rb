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
#  director_id         :integer
#  boxoffice_us        :integer
#  boxoffice_foreign   :integer
#  boxoffice_worldwide :integer
#

class Movie < ActiveRecord::Base
  extend FriendlyId
  before_save :update_averages
  
  has_many :ratings
  has_many :characters
  has_many :quotes
  has_many :actors, through: :characters, source: :person
  has_many :ranked_characters, -> { ranked }, :class_name => 'Character'
  has_many :stars, through: :ranked_characters, source: :person
  
  belongs_to :director, class_name: 'Person'
  accepts_nested_attributes_for :characters, allow_destroy: true
  
  acts_as_taggable
  acts_as_api
  include ApiV1::Movie
  friendly_id :slug_candidates, use: :slugged
  
  validates :title,
    presence: true
      
  validates :year,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
    
  validates :summary,
    presence: true
    
  validates :boxoffice_us,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    
  validates :boxoffice_foreign,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    
  validates :boxoffice_worldwide,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
      
  has_attached_file :poster, styles: {
      thumb: '125x125>',
      medium: '450x450>'
    },
    s3_protocol: 'https'
  
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :poster, :content_type => /\Aimage\/.*\Z/
      
  def slug_candidates
    [
      :title,
      [:title, :year]
    ]
  end
  
  def domestic_rank
    return Movie.where('boxoffice_us > ' + self.boxoffice_us.to_s).order('boxoffice_us DESC').count + 1
  end
  
  def foreign_rank
    return Movie.where('boxoffice_foreign > ' + self.boxoffice_foreign.to_s).order('boxoffice_foreign DESC').count + 1
  end
  
  def worldwide_rank
    return Movie.where('boxoffice_worldwide > ' + self.boxoffice_worldwide.to_s).order('boxoffice_worldwide DESC').count + 1
  end

  def update_averages
    count = self.ratings.count
    
    if count == 0
      self.avg_v = 0
      self.avg_n = 0
      self.avg_l = 0
      self.avg_at = 0
    else
      update_v count
      update_n count
      update_l count
      update_at count  
    end
  end

  private
  
    def update_v(count)
      sum = self.ratings.sum(:v)
      
      self.avg_v = (sum / count).ceil
    end
    
    def update_n(count)
      sum = self.ratings.sum(:n)
      
      self.avg_n = (sum / count).ceil
    end
    
    def update_l(count)
      sum = self.ratings.sum(:l)
      
      self.avg_l = (sum / count).ceil
    end
    
    def update_at(count)
      sum = self.ratings.sum(:at)
      
      self.avg_at = (sum / count).ceil
    end
    
    def thumb
      self.poster.url(:thumb)
    end
    
    def medium
      self.poster.url(:medium)
    end
end
