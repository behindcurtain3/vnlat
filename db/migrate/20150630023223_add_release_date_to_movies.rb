class AddReleaseDateToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :released, :date
  end
end
