class CreateMovieVersions < ActiveRecord::Migration
  def change
    create_table :movie_versions do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
      t.string   :author_username
    end
    
    add_index :movie_versions, [:item_type, :item_id]
  end
end
