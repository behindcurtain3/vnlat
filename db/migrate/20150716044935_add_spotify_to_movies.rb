class AddSpotifyToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :spotify, :string
  end
end
