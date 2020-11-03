# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  love       :boolean
#  like       :boolean
#  hate       :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id,
    presence: true

  validates :movie_id,
    presence: true
    
  scope :only_loves, -> { where('love = ?', true) }
  scope :only_likes, -> { where('like = ?', true) }
  scope :only_hates, -> { where('hate = ?', true) }
end
