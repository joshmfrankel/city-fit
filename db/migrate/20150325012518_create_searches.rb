class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :job
      t.string :city
      t.float :score

      t.timestamps null: false
    end
  end
end
