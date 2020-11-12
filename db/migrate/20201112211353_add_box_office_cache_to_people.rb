class AddBoxOfficeCacheToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :boxoffice_us_cache, :integer, default: 0
    add_column :people, :boxoffice_foreign_cache, :integer, default: 0
    add_column :people, :boxoffice_worldwide_cache, :integer, default: 0
  end
end
