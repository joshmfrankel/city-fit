class AddColumnJob2ToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :job2, :string
  end
end
