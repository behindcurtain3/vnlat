class AddAvgLikesToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :avg_love, :float
    add_column :movies, :avg_like, :float
    add_column :movies, :avg_hate, :float
  end
end
