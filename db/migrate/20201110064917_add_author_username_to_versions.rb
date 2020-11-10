class AddAuthorUsernameToVersions < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :author_username, :string
  end
end
