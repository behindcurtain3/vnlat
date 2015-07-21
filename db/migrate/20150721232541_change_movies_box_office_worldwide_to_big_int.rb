class ChangeMoviesBoxOfficeWorldwideToBigInt < ActiveRecord::Migration
  def change
    change_column :movies, :boxoffice_us,  :bigint
    change_column :movies, :boxoffice_foreign,  :bigint
    change_column :movies, :boxoffice_worldwide,  :bigint
  end
end
