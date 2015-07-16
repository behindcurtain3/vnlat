class CreateEarnings < ActiveRecord::Migration
  def change
    create_table :earnings do |t|
      t.references :movie, index: true
      t.integer :domestic, default: 0
      t.integer :foreign, default: 0
      t.integer :worldwide, default: 0
      t.date :date

      t.timestamps
    end
  end
end
