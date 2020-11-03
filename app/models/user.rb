# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :ratings
  has_many :likes
  has_many :movie_versions, foreign_key: 'whodunnit'
  
  def rated?(movie)
    ratings.exists?(:movie_id => movie.id)
  end
  
  def loved?(movie)
    likes.exists?(:movie_id => movie.id, :love => true)
  end
  
  def liked?(movie)
    likes.exists?(:movie_id => movie.id, :like => true)
  end
  
  def hated?(movie)
    likes.exists?(:movie_id => movie.id, :hate => true)
  end
  
  def self.find_version_author(version)
    find(version.whodunnit)   
  end
end
