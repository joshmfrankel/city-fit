class CreateIndeedResults < ActiveRecord::Migration
  def change
    create_table :indeed_results do |t|
      t.float :score
      t.integer :job_total_1
      t.integer :job_total_2
      t.text :job_listing_1
      t.text :job_listing_2
      t.text :job_raw_1
      t.text :job_raw_2
      t.references :search, index: true

      t.timestamps null: false
    end
    add_foreign_key :indeed_results, :searches
  end
end
