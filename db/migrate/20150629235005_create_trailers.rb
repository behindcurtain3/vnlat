class CreateTrailers < ActiveRecord::Migration
  def change
    create_table :trailers do |t|
      t.references :movie, index: true
      t.string :code
      t.boolean :active

      t.timestamps
    end
  end
end
