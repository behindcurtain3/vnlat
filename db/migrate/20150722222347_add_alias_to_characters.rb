class AddAliasToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :alias, :string
  end
end
