class CreateFranchiseMembers < ActiveRecord::Migration
  def change
    create_table :franchise_members do |t|
      t.references :movie, index: true
      t.references :franchise, index: true

      t.timestamps
    end
  end
end
