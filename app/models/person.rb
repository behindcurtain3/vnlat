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
  has_many :crews
  has_many :movies, through: :characters, source: :movie
  has_many :production_credits, through: :crews, source: :movie
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
  
  def credits
    self.movies + self.jobs
  end
  
  def movies_or_credits
    return self.movies unless self.movies.blank?
    return self.production_credits
  end
  
  def slug_candidates
    [
      [:first_name, :last_name],
      [:first_name, :last_name, :born]
    ]
  end
  
  def production_gross_us
    #Movie
    #  .includes(:crews)
    #  .where(crews: { person_id: id})
    #  .count(:boxoffice_us)
    
    # using this becuase the sum distinct sql is bugged on rails, it should look like about with sum instead of count
    sql = 'SELECT SUM(DISTINCT "movies"."boxoffice_us") AS sum_id FROM "movies" LEFT OUTER JOIN "crews" ON "crews"."movie_id" = "movies"."id" WHERE "crews"."person_id" = %d'
    r = ActiveRecord::Base.connection.execute(sprintf(sql, id))
    r.first[0]
  end
  
  def production_gross_foreign
    sql = 'SELECT SUM(DISTINCT "movies"."boxoffice_foreign") AS sum_id FROM "movies" LEFT OUTER JOIN "crews" ON "crews"."movie_id" = "movies"."id" WHERE "crews"."person_id" = %d'
    r = ActiveRecord::Base.connection.execute(sprintf(sql, id))
    r.first[0]
  end
  
  def production_gross_worldwide
    sql = 'SELECT SUM(DISTINCT "movies"."boxoffice_worldwide") AS sum_id FROM "movies" LEFT OUTER JOIN "crews" ON "crews"."movie_id" = "movies"."id" WHERE "crews"."person_id" = %d'
    r = ActiveRecord::Base.connection.execute(sprintf(sql, id))
    r.first[0]
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
