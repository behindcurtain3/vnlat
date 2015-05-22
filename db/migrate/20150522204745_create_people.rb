class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.date :born
      t.date :died
      t.string :twitter
      t.text :biography

      t.timestamps
    end
  end
end
