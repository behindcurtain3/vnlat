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

class Movie < ActiveRecord::Base
  extend FriendlyId
  before_save :update_averages
  
  friendly_id :slug_candidates, use: :slugged
  
  validates :title,
    presence: true
      
  validates :year,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
      
      
  def slug_candidates
    [
      :title,
      [:title, :year]
    ]
  end
  
  private
  
    def update_averages
      update_v
      update_n
      update_l
      update_at      
    end
    
    def update_v
      if self.g_v.nil? && self.j_v.nil?
        self.avg_v = 0
      elsif self.g_v.nil?
        self.avg_v = self.j_v
      elsif self.j_v.nil?
        self.avg_v = self.g_v
      else
        self.avg_v = ((self.g_v + self.j_v) / 2).ceil
      end
    end
    
    def update_n
      if self.g_n.nil? && self.j_n.nil?
        self.avg_n = 0
      elsif self.g_n.nil?
        self.avg_n = self.j_n
      elsif self.j_n.nil?
        self.avg_n = self.g_n
      else
        self.avg_n = ((self.g_n + self.j_n) / 2).ceil
      end
    end
    
    def update_l
      if self.g_l.nil? && self.j_l.nil?
        self.avg_l = 0
      elsif self.g_l.nil?
        self.avg_l = self.j_l
      elsif self.j_l.nil?
        self.avg_l = self.g_l
      else
        self.avg_l = ((self.g_l + self.j_l) / 2).ceil
      end
    end
    
    def update_at
      if self.g_at.nil? && self.j_at.nil?
        self.avg_at = 0
      elsif self.g_at.nil?
        self.avg_at = self.j_at
      elsif self.j_at.nil?
        self.avg_at = self.g_at
      else
        self.avg_at = ((self.g_at + self.j_at) / 2).ceil
      end
    end
end
