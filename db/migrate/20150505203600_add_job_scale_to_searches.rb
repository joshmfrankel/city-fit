class AddJobScaleToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :job_scale, :integer
  end
end
