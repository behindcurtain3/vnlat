class CreateAppearances < ActiveRecord::Migration
  def change
    create_table :appearances do |t|
      t.references :movie, index: true
      t.references :person, index: true
      t.references :character, index: true, default: nil, null: true
      t.string :name
      t.integer :importance
      t.boolean :uncredited, default: false, null: false

      t.timestamps
    end
  end
end
