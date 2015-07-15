class FranchiseMember < ActiveRecord::Base
  belongs_to :movie
  belongs_to :franchise
end
