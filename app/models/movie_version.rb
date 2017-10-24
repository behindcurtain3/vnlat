# == Schema Information
#
# Table name: movie_versions
#
#  id              :integer          not null, primary key
#  item_type       :string(255)      not null
#  item_id         :integer          not null
#  event           :string(255)      not null
#  whodunnit       :string(255)
#  object          :text
#  created_at      :datetime
#  author_username :string(255)
#

class MovieVersion < PaperTrail::Version
  self.table_name = :movie_versions
  default_scope { where.not(event: 'create') } 
  
  belongs_to :user, foreign_key: 'whodunnit'
end
