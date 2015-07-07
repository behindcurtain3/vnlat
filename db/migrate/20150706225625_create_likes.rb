class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true
      t.references :movie, index: true
      t.boolean :love
      t.boolean :like
      t.boolean :hate

      t.timestamps
    end
  end
end
