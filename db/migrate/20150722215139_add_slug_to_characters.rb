class AddSlugToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :slug, :string, unique: true
  end
end
