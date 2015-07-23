class RenameQuotesColumn < ActiveRecord::Migration
  def change
    rename_column :quotes, :character_id, :appearance_id
  end
end
