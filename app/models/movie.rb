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
#  runtime             :integer
#  mpaa                :string(255)
#  released            :date
#

class Movie < ActiveRecord::Base
  extend FriendlyId
  before_save :update_averages
  
  has_many :ratings
  has_many :characters
  has_many :crews
  has_many :quotes
  has_many :actors, through: :characters, source: :person
  has_many :workers, through: :crews, source: :person
  has_many :ranked_characters, -> { ranked }, :class_name => 'Character'
  has_many :stars, through: :ranked_characters, source: :person
  has_many :trailers
  has_many :reviews
  has_many :likes
  
  belongs_to :director, class_name: 'Person'
  accepts_nested_attributes_for :characters, allow_destroy: true
  accepts_nested_attributes_for :crews, allow_destroy: true
  accepts_nested_attributes_for :trailers, allow_destroy: true
  accepts_nested_attributes_for :reviews, allow_destroy: true
  accepts_nested_attributes_for :quotes, allow_destroy: true
  
  acts_as_taggable
  acts_as_api
  include ApiV1::Movie
  friendly_id :slug_candidates, use: :slugged
  
  # for auditing changes
  has_paper_trail class_name: 'MovieVersion'
  
  validates :title,
    presence: true
      
  validates :year,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
    
  validates :boxoffice_us,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    allow_nil: true
    
  validates :boxoffice_foreign,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    allow_nil: true
    
  validates :boxoffice_worldwide,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    allow_nil: true
      
  has_attached_file :poster, styles: {
      thumb: '125x125>',
      medium: '450x450>'
    },
    s3_protocol: 'https'
  
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :poster, :content_type => /\Aimage\/.*\Z/
      
  scope :popular, -> { order('boxoffice_worldwide DESC') }
      
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
    # update the ratings averages
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
    
    # update the love/like/hate %'s
    count = self.likes.count
    
    if count == 0
      self.avg_love = 0
      self.avg_like = 0
      self.avg_hate = 0
    else
      update_likes count
    end
  end
  
  def any_boxoffice?
    return self.boxoffice_us.present? || self.boxoffice_foreign.present? || self.boxoffice_worldwide.present?
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
    
    def update_likes(count)
      loves = self.likes.only_loves.count
      likes = self.likes.only_likes.count
      hates = self.likes.only_hates.count
      
      self.avg_love = (loves / count) * 100
      self.avg_like = (likes / count) * 100
      self.avg_hate = (hates / count) * 100
    end
    
    def thumb
      self.poster.url(:thumb)
    end
    
    def medium
      self.poster.url(:medium)
    end
end
