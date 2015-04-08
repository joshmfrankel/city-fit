class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :job1
      t.string :job2
      t.string :location
      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :searches, :users
    add_index :searches, [:user_id, :created_at]
  end
end
