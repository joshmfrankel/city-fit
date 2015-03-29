class AlterColumnJobToJob1 < ActiveRecord::Migration
  def change
    rename_column :searches, :job, :job1
  end
end
