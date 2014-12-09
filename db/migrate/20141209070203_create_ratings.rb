class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :v
      t.integer :n
      t.integer :l
      t.integer :at

      t.timestamps
    end
    
    add_index :ratings, :user_id
    add_index :ratings, :movie_id
  end
end
