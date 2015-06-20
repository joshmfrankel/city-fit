class AddMeetupFieldToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :meetup_interests, :text
  end
end
