class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :movie, index: true
      t.string :code
      t.boolean :active

      t.timestamps
    end
  end
end
