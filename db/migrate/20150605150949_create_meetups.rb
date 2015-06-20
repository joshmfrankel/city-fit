class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.text :name
      t.text :link
      t.float :score
      t.integer :members
      t.references :search, index: true

      t.timestamps null: false
    end
    add_foreign_key :meetups, :searches
  end
end
