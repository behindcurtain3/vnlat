class AddAttributesToFranchiseMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :franchise_members, :position, :integer
    add_column :franchise_members, :previous_id, :integer
    add_column :franchise_members, :next_id, :integer

    add_index :franchise_members, :previous_id
    add_index :franchise_members, :next_id
  end
end
