class ChangeCachesToBigInts < ActiveRecord::Migration[5.2]
  def change
    change_column :people, :boxoffice_us_cache, :bigint
    change_column :people, :boxoffice_foreign_cache, :bigint
    change_column :people, :boxoffice_worldwide_cache, :bigint
  end
end
