class AddBoxOfficeToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :boxoffice_us, :integer
    add_column :movies, :boxoffice_foreign, :integer
    add_column :movies, :boxoffice_worldwide, :integer
  end
end
