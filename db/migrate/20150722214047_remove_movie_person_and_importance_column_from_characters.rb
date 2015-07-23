class RemoveMoviePersonAndImportanceColumnFromCharacters < ActiveRecord::Migration
  def change
    remove_column :characters, :movie_id
    remove_column :characters, :person_id
    remove_column :characters, :importance
  end
end
