class AlterGroupsAndAddRelevancy < ActiveRecord::Migration
  def change
    rename_column :meetups, :total_groups, :total_meetups
    add_column :meetups, :avg_relevancy, :float
  end
end
