class AddMpaaToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :mpaa, :string
  end
end
