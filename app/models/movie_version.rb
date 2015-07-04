class MovieVersion < PaperTrail::Version
  self.table_name = :movie_versions
  default_scope { where.not(event: 'create') } 
end
