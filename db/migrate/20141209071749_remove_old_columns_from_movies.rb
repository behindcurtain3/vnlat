class RemoveOldColumnsFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :g_v
    remove_column :movies, :g_n
    remove_column :movies, :g_l
    remove_column :movies, :g_at
    remove_column :movies, :j_v
    remove_column :movies, :j_n
    remove_column :movies, :j_l
    remove_column :movies, :j_at
    remove_column :movies, :g_comments
    remove_column :movies, :j_comments
  end
end
