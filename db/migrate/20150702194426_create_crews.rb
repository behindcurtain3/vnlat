class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
      t.references :movie, index: true
      t.references :person, index: true
      t.string :role
      t.integer :importance, default: 0
      t.boolean :featured

      t.timestamps
    end
  end
end
