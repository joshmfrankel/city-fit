class AlterMeetupColumns < ActiveRecord::Migration
  def change
    add_column :meetups, :total_groups, :integer
    add_column :meetups, :avg_relevancy, :float
    rename_column :meetups, :members, :total_members
    remove_column :meetups, :link
  end
end
