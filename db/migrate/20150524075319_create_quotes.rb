class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :text
      t.references :movie, index: true
      t.references :character, index: true

      t.timestamps
    end
  end
end
