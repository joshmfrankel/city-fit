class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.float :score
      t.integer :job1Total
      t.integer :job2Total
      t.text :job1Listing
      t.text :job2Listing
      t.references :search, index: true

      t.timestamps null: false
    end
    add_foreign_key :results, :searches
  end
end
