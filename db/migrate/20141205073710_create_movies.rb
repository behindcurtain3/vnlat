class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.integer :avg_v
      t.integer :avg_n
      t.integer :avg_l
      t.integer :avg_at
      t.integer :g_v
      t.integer :g_n
      t.integer :g_l
      t.integer :g_at
      t.integer :j_v
      t.integer :j_n
      t.integer :j_l
      t.integer :j_at
      t.string :g_comments
      t.string :j_comments

      t.timestamps
    end
    
    add_index :movies, :title
  end
end
