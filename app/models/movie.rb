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

class Movie < ActiveRecord::Base
  extend FriendlyId
  before_save :update_averages
  
  has_many :ratings
  
  acts_as_taggable
  acts_as_api
  friendly_id :slug_candidates, use: :slugged
  
  validates :title,
    presence: true
      
  validates :year,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
    
  validates :summary,
    presence: true
      
  has_attached_file :poster, styles: {
      thumb: '100x100>',
      medium: '450x450>'
    },
    s3_protocol: 'https'
  
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :poster, :content_type => /\Aimage\/.*\Z/
      
  api_accessible :public do |template|
    template.add :slug, as: :id
    template.add :title
    template.add :year
    template.add :avg_v, as: :V
    template.add :avg_n, as: :N
    template.add :avg_l, as: :L
    template.add :avg_at, as: :AT
    template.add :thumb, as: :thumbnail
    template.add :medium, as: :poster
  end    

  api_accessible :detailed, extend: :public do |template|
    template.add :tag_list
  end
      
  def slug_candidates
    [
      :title,
      [:title, :year]
    ]
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
