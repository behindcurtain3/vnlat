class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.references :person, index: true
      t.references :movie, index: true
      t.string :name
      t.integer :importance

      t.timestamps
    end
  end
end
